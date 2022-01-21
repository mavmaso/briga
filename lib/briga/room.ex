defmodule Briga.Room do
  use Agent

  def start_link(name) do
    Agent.start_link(fn -> %{host: %{}, rival: %{}, scene: 1} end, name: global_name(name))
  end

  def whereis(name) do
    case :global.whereis_name({__MODULE__, name}) do
      :undefined -> nil
      pid -> pid
    end
  end

  def get(name) do
    Agent.get(global_name(name), & &1)
  end

  defp global_name(name), do: {:global, {__MODULE__, name}}
end
