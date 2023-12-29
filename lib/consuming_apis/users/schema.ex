defmodule ConsumingApis.Users.Schema do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @fields [:password]
  @derive {Jason.Encoder, only: [:id]}

  schema "users" do
    field :password, :string
  end

  def changeset(struct \\ %__MODULE__{}, values) do
    struct
    |> cast(values, @fields)
    |> validate_required(@fields)
    |> validate_length(:password, min: 12)
    |> encrypt_password()
    |> handle_errors()
  end

  defp encrypt_password(%Changeset{valid?: true} = changeset) do
    %{changes: %{password: password}} = changeset
    hash = Pbkdf2.hash_pwd_salt(password)
    change(changeset, %{password: hash})
  end

  defp encrypt_password(changeset), do: changeset

  defp handle_errors(%Changeset{valid?: false} = changeset) do
    reason =
      traverse_errors(changeset, fn {msg, opts} ->
        Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
          opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
        end)
      end)

    {:error, reason, 400}
  end

  defp handle_errors(changeset), do: changeset
end
