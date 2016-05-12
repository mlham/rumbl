defmodule Rumbl.PageController do
  use Rumbl.Web, :controller


  def index(conn, _params) do
    render conn, "index.html"
  end

  def clearme(conn,_params) do
    Rumbl.Auth.logout(conn)
      conn
      |> put_flash(:info, "Cleared your session!")
      |> redirect(to: user_path(conn, :index))

  end
end
