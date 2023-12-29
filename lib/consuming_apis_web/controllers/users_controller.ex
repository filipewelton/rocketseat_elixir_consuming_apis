defmodule ConsumingApisWeb.UsersController do
  use ConsumingApisWeb, :controller

  alias ConsumingApis.Users.{Create, Get}
  alias ConsumingApisWeb.Auth.Guardian
  alias ConsumingApis.Client

  def create(conn, params) do
    with {:ok, id} <- Create.call(params) do
      parsed = Jason.encode!(%{id: id})

      conn
      |> put_status(201)
      |> json(parsed)
    else
      error ->
        parsed = Jason.encode!(error)

        conn
        |> put_status(500)
        |> json(parsed)
    end
  end

  def login(conn, params) do
    with {:ok, user} <- Get.by_id(params),
         {:ok, token} <- Guardian.authenticate(user, params) do
      parsed = Jason.encode!(%{token: token})

      conn
      |> put_status(200)
      |> json(parsed)
    end
  end

  def show(conn, %{"username" => username}) do
    with {:ok, repos} <- Client.get_repositories(username) do
      parsed = Jason.encode!(%{repositories: repos})

      conn
      |> put_status(200)
      |> json(parsed)
    end
  end
end
