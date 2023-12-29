defmodule ConsumingApis.Users.Create do
  alias ConsumingApis.Repo
  alias ConsumingApis.Users.Schema
  alias Ecto.Changeset

  def call(params) do
    with {:ok, changeset} <- handle_changeset(params) do
      handle_creation(changeset)
    end
  end

  defp handle_changeset(params) do
    case Schema.changeset(params) do
      %Changeset{valid?: true} = changeset -> {:ok, changeset}
      error -> error
    end
  end

  defp handle_creation(changeset) do
    case Repo.insert(changeset) do
      {:ok, %Schema{id: id}} -> {:ok, id}
      {:error, reason} -> {:error, reason, 409}
    end
  end
end
