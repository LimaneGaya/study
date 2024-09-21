defmodule Cards do
  def create_deck do
    values = ["ace", "2", "3", "4", "5", "6", "7", "8", "9"]
    suits = ["Spades", "Heart", "Clubs", "Diamonds"]
    for v <- values, s <- suits, do: "#{v} of #{s}"
  end

  @spec shuffle(list(String.t())) :: list(String.t())
  def shuffle(deck), do: Enum.shuffle(deck)

  @spec contains?(list(String.t()), String.t()) :: boolean()
  def contains?(deck, element), do: Enum.member?(deck, element)

  @spec deal(list(String.t()), number()) :: {list(String.t()), list(String.t())}
  def deal(deck, hand_size), do: Enum.split(deck, hand_size)
end
