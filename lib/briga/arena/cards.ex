defmodule Briga.Arena.Cards do
  @moduledoc """
  WIP
  """

  def weak, do: %{value: 2, frame: 2, text: "weak", type: :a}
  def strong, do: %{value: 5, frame: 4, text: "strong", type: :a}
  def grab, do: %{value: 3, frame: 5, text: "grap", type: :a}

  def block, do: %{value: -1, frame: 1, text: "block", type: :d}
end
