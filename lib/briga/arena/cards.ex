defmodule Briga.Arena.Cards do
  @moduledoc """
  This module contains the cards/powers.
  """

  def weak, do: %{text: "atack", type: :stance, cost: 0, value: 1}
  def strong, do: %{text: "strong", type: :action, cost: 0, value: 3}
  def grab, do: %{text: "grap", type: :stance, cost: 0, value: 2}
  def block, do: %{text: "block", type: :stance, cost: 0, value: 2}
end
