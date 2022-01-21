defmodule BrigaWeb.PageControllerTest do
  use BrigaWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Create a new room"
  end
end
