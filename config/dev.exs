import Config

config :consuming_apis, ConsumingApis.Repo,
  username: "dev",
  password: "dev",
  hostname: "localhost",
  database: "app",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :consuming_apis, ConsumingApisWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "I89rIs6iyQDX1DiPmjqBXabHNadYqb9tg9M6hLVe2RKRmVtoetMi5S352CeScB6X",
  watchers: []

config :consuming_apis, dev_routes: true

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime
