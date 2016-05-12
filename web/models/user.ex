defmodule Rumbl.User do
  use Rumbl.Web, :model

  @moduledoc false

  min_password_length=6
  max_password_length=100

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :videos, Rumbl.Video
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(name username), [])
    |> validate_length(:username, min: 1, max: 20)
    |> validate_length(:name, min: 1)
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [] )
    |> validate_length(:password, min: 6, max: 100)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
      case changeset do
        %Ecto.Changeset{valid?: true, changes: %{password: passwd}} ->
          put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(passwd))
        _ ->
          changeset
      end
  end
end