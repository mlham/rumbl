defmodule Rumbl.SessionController do
  use Rumbl.Web, :controller
  @moduledoc false

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session"=>%{"username" => user, "password" => password}}) do
    case Rumbl.Auth.login_by_username_and_password(conn, user, password, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome Back!")
        |> redirect(to: user_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid Username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Rumbl.Auth.logout()
    |> redirect(to: page_path(conn, :index))
  end
end