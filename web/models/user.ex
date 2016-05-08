defmodule Rumbl.User do
  use Rumbl.Web, :model

  @moduledoc false

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(name username), [])
    |> validate_length(:username, min: 1, max: 20)
    |> validate_length(:name, min: 1)
  end
end