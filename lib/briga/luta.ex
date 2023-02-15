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
    end)
  end

  defp global_name(name), do: {:global, {__MODULE__, name}}

  defp data do
    %{
      host: Briga.Arena.Souls.player(),
      rival: Briga.Arena.Souls.player()
    }
  end
end
