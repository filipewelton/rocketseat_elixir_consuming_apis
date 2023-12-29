defmodule ConsumingApisWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :consuming_apis

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
