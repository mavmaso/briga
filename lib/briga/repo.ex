defmodule Briga.Repo do
  use Ecto.Repo,
    otp_app: :briga,
    adapter: Ecto.Adapters.Postgres
end
