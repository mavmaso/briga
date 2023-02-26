defmodule BrigaWeb.PageControllerTest do
  use BrigaWeb.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Create a new arena"
  end
end
