defmodule Briga.Luta do
  @moduledoc "This module is responsible for being the source of truth for the combat/fight itself.
  Another point is to test the limits of Agent within OTP rather than using a GenServer,
  which would be more robust, but using Agent could still be considered clean code."

  use Agent

  alias Briga.Arena.Souls

  def start_link(name) do
    Agent.start_link(fn -> data() end, name: global_name(name))
  end

  @doc "Returns the PID of the combat Agent process.
  Another concept test to understand the limitations and functionality of :global."
  @spec whereis(atom) :: pid | :not_found
  def whereis(name) do
    if :global.whereis_name({__MODULE__, name}) == :undefined, do: :not_found, else: :ok
  end

  @doc "Returns the values within the arena/fight of the given ID/name."
  @spec get_arena(atom) :: map | :arena_not_found
  def get_arena(nil), do: :arena_not_found
  def get_arena(name), do: Agent.get(global_name(name), & &1)

  @doc "Updates the data of one of the players within the arena."
  @spec update_player(atom, atom, atom, any) :: :ok
  def update_player(name, player, key, value) do
    Agent.update(global_name(name), fn state ->
      put_in(state, [player, key], value)
    end)
  end

  @doc "Starts the fight by counting the turns/time and letting the combat happen."
  def start_turn(name, :pre_fight) do
    count_turn(name)
    Agent.update(global_name(name), fn s -> Map.merge(s, %{phase: :fight}) end, :infinity)

    Task.async(fn -> turn(name) end)
  end

  def start_turn(_name, _phase), do: :ok

  defp count_turn(name) do
    Agent.update(
      global_name(name),
      fn state ->
        state
        |> put_in([:turn], state.turn + 1)
        |> put_in([:host, :focus], min(state.host.focus + 1, 10))
        |> put_in([:rival, :focus], min(state.rival.focus + 1, 10))
      end,
      :infinity
    )
  end

  defp turn(name) do
    :timer.sleep(3_000)

    if get_arena(name)[:phase] == :finish do
      :ok
    else
      count_turn(name)
      turn(name)
    end
  end

  defp global_name(name), do: {:global, {__MODULE__, name}}

  defp data do
    %{
      turn: 0,
      host: Souls.player(),
      rival: Souls.player(),
      # :fight, :finish
      phase: :pre_fight
    }
  end
end
