defmodule BrigaWeb.ArenaLive do
  use BrigaWeb, :live_view

  alias Briga.Arena.Cards
  alias Briga.Luta

  alias BrigaWeb.Endpoint

  def mount(_params, session, socket) do
    arena = session["arena"]

    if connected?(socket), do: Endpoint.subscribe(arena)

    {:ok, assign(socket, %{
      arena: arena,
      username: session["username"],
      role: session["role"] |> String.to_atom(),
      host: Luta.get(arena)[:host],
      rival: Luta.get(arena)[:rival],
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
