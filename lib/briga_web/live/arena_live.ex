defmodule BrigaWeb.ArenaLive do
  use BrigaWeb, :live_view

  alias Briga.Arena.Cards
  alias Briga.Luta

  alias BrigaWeb.Endpoint

  def mount(_params, session, socket) do
    name = session["arena"]
    arena = Luta.get_arena(name)

    if connected?(socket), do: Endpoint.subscribe(name)
    Luta.start_turn(name, arena.phase)

    {:ok,
     assign(socket, %{
       name: name,
       username: session["username"],
       role: session["role"] |> String.to_atom(),
       host: arena.host,
       rival: arena.rival,
       turn: arena.turn,
       phase: arena.phase,
       evento: [" "],
       modal: true,
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
    Luta.update_player(state.name, state.role, :stance, date)

    Endpoint.broadcast(state.name, "event", "#{state.role}: #{date}")

    {:noreply, socket}
  end

  def handle_event("atack", _value, %{assigns: state} = socket) do
    date = :atack
    Luta.update_player(state.name, state.role, :stance, date)

    Endpoint.broadcast(state.name, "event", "#{state.role}: #{date}")

    {:noreply, socket}
  end

  def handle_event("save", value, socket) do
    IO.inspect value
    {:noreply, assign(socket, modal: false)}
  end

  def handle_event(_button, _value, socket), do: {:noreply, socket}

  def handle_info(%{event: "event", payload: value}, %{assigns: state} = socket) do
    arena = Luta.get_arena(state.name)

    host = arena.host
    rival = arena.rival
    turn = arena.turn
    evento = ["Turn: #{turn} - #{value}" | state.evento]

    {:noreply, assign(socket, evento: evento, host: host, rival: rival, turn: turn)}
  end

  def handle_info(params, socket) do
    IO.inspect(params, label: :arena_debug)

    {:noreply, socket}
  end
end
