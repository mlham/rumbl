defmodule Rumbl.UserController do
  use Rumbl.Web, :controller
  require Logger

  @moduledoc """
  UserController for my application.
  """

  def index(conn, _params) do
    users = Repo.all(Rumbl.User)

    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get Rumbl.User, id
    Logger.debug "I have a user: #{user.name}"
    render conn, "show.html", user: user
  end
end