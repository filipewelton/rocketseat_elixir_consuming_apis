import Config

config :consuming_apis,
  ecto_repos: [ConsumingApis.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

config :consuming_apis, ConsumingApisWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: ConsumingApisWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ConsumingApis.PubSub,
  live_view: [signing_salt: "fOdEDxfE"]

config :consuming_apis, ConsumingApisWeb.Auth.Guardian,
  issuer: "Consuming APIs",
  secret_key: "rqBlxPY58h/PdOKUhEjVGo3i0gm3DXbQmrGUKS001sbdnaZA1FlE5X6n21QI3om/"

config :consuming_apis, ConsumingApisWeb.Auth.Pipeline,
  module: ConsumingApisWeb.Auth.Guardian,
  error_handler: ConsumingApisWeb.Auth.ErrorHandler

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :tesla, adapter: Tesla.Adapter.Hackney

import_config "#{config_env()}.exs"
