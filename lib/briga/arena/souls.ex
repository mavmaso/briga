defmodule Briga.Arena.Souls do
  @moduledoc """
   This module is responsible for managing the different character types in the game,
   as well as the fixed structures/maps that can be chosen and customized later.
  """

  @doc "Returns the default player/character, like a Ryu to the Street Fighter Game"
  def player,
    do: %{
      hp: 30,
      focus: 1,
      stance: :ok,
      atk: 2,
      def: 1
    }
end
