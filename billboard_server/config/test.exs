import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :billboard_server, BillboardServerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "/foLAulDzeXP1I/NeDlSzvhH3FjxP4pNuHP8WU2UC98by5KmQisSTCOVE0RRKmmq",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
