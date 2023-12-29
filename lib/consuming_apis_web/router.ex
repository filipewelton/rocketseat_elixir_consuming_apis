defmodule ConsumingApisWeb.Router do
  use ConsumingApisWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ConsumingApisWeb.Auth.Pipeline
  end

  scope "/api", ConsumingApisWeb do
    pipe_through :api
    post "/users", UsersController, :create
    post "/users/login", UsersController, :login
  end

  scope "/api", ConsumingApisWeb do
    pipe_through [:api, :auth]
    get "/users/repos/:username", UsersController, :show
  end
end
