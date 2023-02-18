defmodule Briga.Luta do
  use Agent

  def start_link(name) do
    Agent.start_link(fn -> data() end, name: global_name(name))
  end

  @doc"WIP"
  def whereis(name) do
    case :global.whereis_name({__MODULE__, name}) do
      :undefined -> nil
      pid -> pid
    end
  end

  @doc"WIP"
  def get_arena(name), do: Agent.get(global_name(name), & &1)

  @doc"WIP"
  def update_players(name, value) do
    Agent.get_and_update(global_name(name), fn state ->
      state = Map.merge(state, value)

      {state, state}
    end, :infinity)
  end

  @doc"WIP"
  def start_turn(name, :pre_fight) do
    count_turn(name)
    Agent.update(global_name(name), fn s -> Map.merge(s, %{phase: :fight}) end, :infinity)

    Task.async(fn -> turn(name) end)
  end

  def start_turn(_name, _phase), do: :ok

  defp count_turn(name) do
    Agent.update(global_name(name), fn state ->
      Map.merge(state, %{turn: state.turn + 1})
    end, :infinity)
  end

  defp turn(name) do
    :timer.sleep(3_000)

    case get_arena(name)[:phase] do
      :finish ->
        :ok
      _ ->
        count_turn(name)
        turn(name)
    end
  end

  defp global_name(name), do: {:global, {__MODULE__, name}}

  defp data do
    %{
      turn: 0,
      host: Briga.Arena.Souls.player(),
      rival: Briga.Arena.Souls.player(),
      phase: :pre_fight # :fight, :finish
    }
  end
end
