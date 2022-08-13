defmodule BrigaWeb.ArenaLive do
  use BrigaWeb, :live_view

  alias Briga.Arena.Cards
  # alias Briga.Arena
  alias Briga.Luta

  alias BrigaWeb.Endpoint

  def mount(_params, session, socket) do
    name = session["name"]

    if connected?(socket), do: Endpoint.subscribe(name)

    {:ok, assign(socket, %{
      name: name,
      role: session["role"] |> String.to_atom(),
      host: Luta.get(name)[:host],
      rival: Luta.get(name)[:rival],
      cards: [
        Cards.weak(), Cards.strong(), Cards.grab(), Cards.block()
      ]
    })}
  end

  def handle_event("block", _value, %{assigns: state} = socket) do
    date = :block
    Endpoint.broadcast(state.name, "event", date)

    {:noreply, socket}
  end

  def handle_info(%{event: "event", payload: value}, %{assigns: state} = socket) do
    map = %{state.role => Map.merge(state[state.role], %{status: value})}

    {:noreply, assign(socket, map)}
  end
end
