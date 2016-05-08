defmodule Rumbl.User do
  use Rumbl.Web, :model

  @moduledoc false

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
  end
end