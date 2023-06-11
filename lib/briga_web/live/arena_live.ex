defmodule BrigaWeb.ArenaLive do
  use BrigaWeb, :live_view

  alias Briga.Arena.Cards
  alias Briga.Luta

  alias BrigaWeb.Endpoint

  def mount(params, session, socket) do
    name = session["arena"] || params["arena"]
    arena = Luta.get_arena(name)

    if connected?(socket), do: Endpoint.subscribe(name)

    if Luta.whereis(name) != :not_found do
      values = %{
        name: name,
        username: " ",
        role: :guest,
        host: arena.host,
        rival: arena.rival,
        turn: arena.turn,
        phase: arena.phase,
        event: [" "],
        modal: true,
        cards: [
          Cards.weak(),
          Cards.strong(),
          Cards.grab(),
          Cards.block()
        ]
      }

      {:ok, assign(socket, values)}
    else
      {:ok, redirect(socket, to: "/")}
    end
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

  def handle_event("registry", value, %{assigns: state} = socket) do
    role = String.to_atom(value["role"])

    Luta.start_turn(state.name, state.phase)

    {:noreply, assign(socket, modal: false, username: value["username"], role: role)}
  end

  def handle_event(_button, _value, socket), do: {:noreply, socket}

  def handle_info(%{event: "event", payload: value}, %{assigns: state} = socket) do
    arena = Luta.get_arena(state.name)

    host = arena.host
    rival = arena.rival
    turn = arena.turn
    event = ["Turn: #{turn} - #{value}" | state.event]

    {:noreply, assign(socket, event: event, host: host, rival: rival, turn: turn)}
  end

  def handle_info(_params, socket) do
    {:noreply, socket}
  end
end
