defmodule ConsumingApis.Repo do
  use Ecto.Repo,
    otp_app: :consuming_apis,
    adapter: Ecto.Adapters.Postgres
end
