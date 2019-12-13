defmodule DumenuffInterfaceWeb.ScoresView do
  use DumenuffInterfaceWeb, :view

  alias DumenuffEngine.{Player}

  def real_name(%Player{ethnicity: :bot} = player) do
    "a bot"
  end

  def real_name(%Player{ethnicity: :human} = player) do
    player.real_name
  end

  def score(%Player{scores: scores} = player) do
    IO.inspect(scores, label: "scores")
    4
  end

  def sort_by_score(players) do
    Enum.sort_by(players, sum_scores(Map.fetch(&1, :scores)))
  end

  def sum_scores(scores) do
    IO.inspect(scores, label: "sum_scores / scores")
    Enum.reduce(scores, 0, fn({_k, v}, acc) -> v + acc end)
  end
end
