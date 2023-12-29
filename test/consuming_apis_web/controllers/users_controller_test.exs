defmodule ConsumingApisWeb.UsersControllerTest do
  use ConsumingApisWeb.ConnCase

  describe "create" do
    test "when passing all valid parameters", %{conn: conn} do
      params = %{"password" => "123456789012"}

      conn
      |> post("/api/users", params)
      |> json_response(201)
    end
  end

  describe "login" do
    test "when passing all valid parameters", %{conn: conn} do
      password = "123456789012"
      params = %{"password" => password}

      %{"id" => id} =
        conn
        |> post("/api/users", params)
        |> json_response(201)
        |> Jason.decode!()

      params = %{
        "id" => id,
        "password" => password
      }

      conn
      |> post("/api/users/login", params)
      |> json_response(200)
    end
  end

  describe "repos" do
    test "when passing all valid parameters", %{conn: conn} do
      password = "123456789012"
      params = %{"password" => password}

      %{"id" => id} =
        conn
        |> post("/api/users", params)
        |> json_response(201)
        |> Jason.decode!()

      params = %{
        "id" => id,
        "password" => password
      }

      %{"token" => token} =
        conn
        |> post("/api/users/login", params)
        |> json_response(200)
        |> Jason.decode!()

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      conn
      |> get("/api/users/repos/filipewelton")
      |> json_response(200)
    end
  end
end
