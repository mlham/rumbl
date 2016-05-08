defmodule Rumbl.UserView do
  use Rumbl.Web, :view
  @moduledoc false


  alias Rumbl.User

  def first_Name (%{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end


end