defmodule BrigaWeb.ArenaLiveTest do
  use BrigaWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  describe "mount" do
    test "render ok when entry as Host", %{conn: conn} do
      num = "#{System.unique_integer([:positive])}"
      Briga.LutaSupervisor.create(num)
      value = %{username: "Nome", role: "host"}

      {:ok, lv, _html} = live(conn, "/battle?arena=#{num}")

      assert render(lv) =~ "role: guest"
      assert render(lv) =~ "stance: ok"
      assert render_submit(lv, :registry, value) =~ value.username
      assert render(lv) =~ "role: #{value.role}"
      assert lv |> element("#card-atack") |> render_click()
      assert render(lv) =~ "stance: atack"
    end
  end
end
