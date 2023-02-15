defmodule BrigaWeb.ArenaLive do
  use BrigaWeb, :live_view

  alias Briga.Arena.Cards
  alias Briga.Luta

  alias BrigaWeb.Endpoint

  def mount(_params, session, socket) do
    arena = session["arena"]

    if connected?(socket), do: Endpoint.subscribe(arena)

    {:ok,
     assign(socket, %{
       arena: arena,
       username: session["username"],
       role: session["role"] |> String.to_atom(),
       host: Luta.get_arena(arena)[:host],
       rival: Luta.get_arena(arena)[:rival],
       turn: 0,
       evento: [" "],
       cards: [
         Cards.weak(),
         Cards.strong(),
         Cards.grab(),
         Cards.block()
       ]
     })}
  end

  def handle_event("block", _value, %{assigns: state} = socket) do
    date = :block

    Luta.update_players(state.arena, %{
      state.role => Map.merge(state[state.role], %{stance: date})
    })

    Endpoint.broadcast(state.arena, "event", date)

    {:noreply, socket}
  end

  def handle_event("atack", _value, %{assigns: state} = socket) do
    date = :atack

    Luta.update_players(state.arena, %{
      state.role => Map.merge(state[state.role], %{stance: date})
    })

    Endpoint.broadcast(state.arena, "event", date)

    {:noreply, socket}
  end

  def handle_info(%{event: "event", payload: value}, %{assigns: state} = socket) do
    arena = state.arena
    evento = [" #{value} " | state.evento]
    host = Luta.get_arena(arena)[:host]
    rival = Luta.get_arena(arena)[:rival]

    {:noreply, assign(socket, evento: evento, host: host, rival: rival)}
  end
end
