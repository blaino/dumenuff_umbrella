defmodule DumenuffInterfaceWeb.ScoresView do
  use DumenuffInterfaceWeb, :view

  alias DumenuffEngine.{Player}

  def real_name(%Player{ethnicity: :bot} = player) do
    "a bot"
  end

  def real_name(%Player{ethnicity: :human} = player) do
    player.real_name
  end
end
