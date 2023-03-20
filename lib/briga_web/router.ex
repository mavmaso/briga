defmodule BrigaWeb.Router do
  use BrigaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BrigaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BrigaWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/", PageController, :luta

    live "/battle", ArenaLive
  end

  # live_session :default, on_mount: BrigaWeb.Hooks do
  #   scope "/", BrigaWeb do
  #     pipe_through :browser

  #     live "/arena", ArenaLive
  #   end
  # end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BrigaWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
