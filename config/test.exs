import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :briga, Briga.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "briga_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :briga, BrigaWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "suz15gbAk9YSky1wMxthQc8AIB7/QTPQXL4j35oWYInKonoHNsbKi4qN3xEDz6Fv",
  server: true

# In test we don't send emails.
config :briga, Briga.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :briga,
  sql_sandbox: true

config :wallaby,
  otp_app: :briga,
  screenshot_on_failure: true,
  chromedriver: [
    # binary: "assets/node_modules/chromedriver/bin/chromedriver",
    # path: "assets/node_modules/chromedriver/bin/chromedriver",
    headless: true
  ]
