defmodule Rumbl.UserView do
  require Logger

  use Rumbl.Web, :view
  @moduledoc false


  alias Rumbl.User

  def first_name (%User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end


end