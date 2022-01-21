defmodule BrigaWeb.PageController do
  use BrigaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", form: :form)
  end

  def room(conn, _params) do
    num = System.unique_integer([:positive]) |> Integer.to_string()
    Briga.RoomSupervisor.create(num)

    redirect(conn, to: "/battle?n=#{num}")
  end
end
