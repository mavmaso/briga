defmodule BrigaWeb.BattleController do
  use BrigaWeb, :controller

  alias Briga.Luta

  import Phoenix.LiveView.Controller

  def show(conn, %{"n" => arena}) do
    case Luta.whereis(arena) do
      nil ->
        redirect(conn, to: "/")

      _pid ->
        render(conn, "show.html", form: :form, arena: arena)
    end
  end

  def show(conn, _), do: redirect(conn, to: "/")

  def start(conn, %{"form" => params}) do
    session = %{
      "role" => params["role"] || "guest",
      "username" => params["username"],
      "arena" => params["arena"]
    }

    live_render(conn, BrigaWeb.ArenaLive, session: session)
  end
end
