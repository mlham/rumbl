defmodule Rumbl.Repo do
  # use Ecto.Repo, otp_app: :rumbl
  @moduledoc """
  In memory repository
  """

  def all(Rumbl.User) do
    [   %Rumbl.User{id: "1", name: "Scott", username: "smaxwell", password: "dbguy"},
        %Rumbl.User{id: "2", name: "Ajay", username: "ajay", password: "appguy"},
        %Rumbl.User{id: "3", name: "Ari", username: "arig", password: "nativeguy"},
        %Rumbl.User{id: "4", name: "Mason", username: "mlham", password: "managementguy"}
    ]
  end

  def all(_module), do: []

  def get(module, id) do
    Enum.find all(module), fn map -> map.id == id end
  end

  def get_by(module, params) do
    Enum.find all(module), fn map ->
        Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    end
  end

end
