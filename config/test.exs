import Config

config :consuming_apis, ConsumingApis.Repo,
  username: "dev",
  password: "dev",
  hostname: "localhost",
  database: "app",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :consuming_apis, ConsumingApisWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "/C0Gsh4lhKO67ngB7x8gR2vOjUqazGxFdbFniCd3rA4a+9HpmlaeIaoBEIkcusFb",
  server: false

config :logger, level: :warning

config :phoenix, :plug_init_mode, :runtime

config :pbkdf2_elixir, :rounds, 1
