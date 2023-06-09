defmodule Briga.Arena do
  @moduledoc """
   This module is responsible for managing the logic of the powers/attacks in the game.
   The idea is to centralize everything related to the core combat here in the future.
  """

  def call(event, args), do: Kernel.apply(__MODULE__, event, args)
end
