defmodule BrigaWeb.BattleController do
  use BrigaWeb, :controller

  alias Briga.Luta

  import Phoenix.LiveView.Controller

  def show(conn, %{"n" => name}) do
    case Luta.whereis(name) do
      nil ->
        redirect(conn, to: "/")
      _pid ->
        render(conn, "show.html", form: :form, name: name)
    end
  end

  def start(conn, %{"form" => params}) do
    live_render(conn, BrigaWeb.ArenaLive, session: %{
      "role" => params["role"],
      "name" => params["name"]
    })
  end
end
