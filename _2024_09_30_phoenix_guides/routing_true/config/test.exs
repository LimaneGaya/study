import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :routing, RoutingWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "yBmsKunH/l36jB8kdhgD7RPMGtE/xzj2LH7KOvf9HPkjB1dxuxF/xhM5dHc2C/lx",
  server: false

# In test we don't send emails
config :routing, Routing.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
