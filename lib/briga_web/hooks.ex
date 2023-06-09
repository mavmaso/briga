defmodule BrigaWeb.Hooks do
  @moduledoc "This module was made to assist in testing/using Wallaby in conjunction with Ecto."

  import Phoenix.Component
  import Phoenix.LiveView

  def on_mount(:default, _params, _session, socket) do
    allow_ecto_sandbox(socket)
    {:cont, socket}
  end

  defp allow_ecto_sandbox(socket) do
    info = if connected?(socket), do: get_connect_info(socket, :user_agent)

    if Application.get_env(:briga, :sql_sandbox) do
      %{assigns: %{phoenix_ecto_sandbox: metadata}} =
        assign_new(socket, :phoenix_ecto_sandbox, fn -> info end)

      Phoenix.Ecto.SQL.Sandbox.allow(metadata, Ecto.Adapters.SQL.Sandbox)
    end
  end
end
