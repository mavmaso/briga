defmodule BrigaWeb.ArenaLive do
  use BrigaWeb, :live_view

  def mount(_params, session, socket) do
    {:ok, assign(socket, %{
      name: "1",
      role: session["role"]
    })}
  end
end
