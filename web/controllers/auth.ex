defmodule Rumbl.Auth do
  @moduledoc false

  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Phoenix.Controller

  alias Rumbl.Router.Helpers

  require Logger

  # This is the init for the plug spec
  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end
  # This is the method that pipelines call from the plug spec
  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && repo.get(Rumbl.User, user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def login_by_username_and_password(conn, username, given_pasaword, opts ) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(Rumbl.User, username: username)

    cond do
      user && checkpw(given_pasaword, user.password_hash) ->
        {:ok, login(conn,user)}
      user->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

    def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You have to be logged into access this page")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end
end