defmodule ConsumingApis.Users.Get do
  alias ConsumingApis.Repo
  alias ConsumingApis.Users.Schema

  def by_id(%{"id" => id}) do
    case Repo.get(Schema, id) do
      %Schema{} = user -> {:ok, user}
      nil -> {:error, "User not found", 404}
    end
  end

  def by_id(_), do: {:error, "ID is required", 400}
end
