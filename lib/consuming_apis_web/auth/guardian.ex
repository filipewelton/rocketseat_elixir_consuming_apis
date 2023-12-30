defmodule ConsumingApisWeb.Auth.Guardian do
  use Guardian, otp_app: :consuming_apis

  alias ConsumingApis.Users.{Schema, Get}

  def subject_for_token(%Schema{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    id = Map.get(claims, "sub")
    Get.by_id(%{"id" => id})
  end

  def build_claims(claims, _resource, _opts) do
    exp = Guardian.timestamp() + 60
    claims = Map.put(claims, "exp", exp)

    {:ok, claims}
  end

  def authenticate(%Schema{} = user, %{"password" => password}) do
    with true <- Pbkdf2.verify_pass(password, user.password),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    end
  end

  def authenticate(_), do: {:error, "Invalid or missing parameters"}
end
