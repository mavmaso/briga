defmodule BrigaWeb.ArenaLiveTest do
  use BrigaWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  describe "mount" do
    test "render ok when entry as Host", %{conn: conn} do
      arena = "#{System.unique_integer([:positive])}"
      Briga.LutaSupervisor.create(arena)
      session = %{"arena" => arena, "username" => "Nome", "role" => "host"}

      {:ok, lv, _html} = live_isolated(conn, BrigaWeb.ArenaLive, session: session)

      assert render(lv) =~ "Nome"
      assert render(lv) =~ "role: host"
      assert render(lv) =~ "stance: ok"

      assert lv |> element("#card-atack") |> render_click()
    end
  end
end
