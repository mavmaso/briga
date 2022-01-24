defmodule BrigaWeb.ArenaLive do
  use BrigaWeb, :live_view

  def mount(_params, session, socket) do
    {:ok, assign(socket, %{
      name: session["name"],
      role: session["role"],
      host: player(),
      rival: player(),
      cards: [weak(), strong(), grab(), block()]
    })}
  end

  def handle_event(event, _value, socket) do

    {:noreply, socket}
  end

  defp player, do: %{hp: 30, focus: 0, status: :ok, card: ["vazio"]}

  defp weak, do: %{value: 2, frame: 2, text: "weak", type: :a}
  defp strong, do: %{value: 5, frame: 4, text: "strong", type: :a}
  defp grab, do: %{value: 3, frame: 5, text: "grap", type: :a}

  defp block, do: %{value: -1, frame: 1, text: "block", type: :d}

end
