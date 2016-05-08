defmodule Rumbl.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
        add :name, :string
        add :username, :string, null: false
        add :password_hash, :string

        add :created_at, :timestamp, null: false, default: fragment("now()")
        add :updated_at, :timestamp, null: false, default: fragment("now()")
    end

    create  unique_index :users, [:username]
  end

end
