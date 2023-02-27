defmodule BrigaWeb.Features.ArenaTest do
  use BrigaWeb.FeatureCase, async: true

  test "Create a Arena", %{session: session} do
    name = "Outro"

    session
    |> visit("/")
    |> click(button("Create a new arena"))
    |> assert_text("- LOBBY -")
    |> fill_in(text_field("Your name:"), with: "#{name}")
    |> click(button("Enter"))
    |> assert_text("user: #{name}")
  end
end
