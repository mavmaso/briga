defmodule Briga.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Briga.Repo,
      BrigaWeb.Telemetry,
      {Phoenix.PubSub, name: Briga.PubSub},
      BrigaWeb.Endpoint,
      Briga.LutaSupervisor
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Briga.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BrigaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
