defmodule BrigaWeb.PageController do
  use BrigaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", form: :form)
  end

  def luta(conn, _params) do
    num = System.unique_integer([:positive]) |> Integer.to_string()
    Briga.LutaSupervisor.create(num)

    redirect(conn, to: "/battle?arena=#{num}")
  end
end
