defmodule Cards do
  @moduledoc """
    Provides methoes for creating and handling a deck of cards.
  """

  def create_deck do
    values = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    suits = ["Spades", "Heart", "Clubs", "Diamonds"]
    for v <- values, s <- suits, do: "#{v} of #{s}"
  end

  @doc """

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {hand, _} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  @spec shuffle(list(String.t())) :: list(String.t())
  def shuffle(deck), do: Enum.shuffle(deck)

  @doc """
  Determins whether a deck contains a given card

  ## Examples

      iex(1)> deck = Cards.create_deck
      iex(2)> Cards.contains?(deck, "Ace of Spades")
      true

  """
  @spec contains?(list(String.t()), String.t()) :: boolean()
  def contains?(deck, element), do: Enum.member?(deck, element)

  @spec deal(list(String.t()), number()) :: {list(String.t()), list(String.t())}
  def deal(deck, hand_size), do: Enum.split(deck, hand_size)

  def save(deck, filename) do
    File.write(filename, :erlang.term_to_binary(deck))
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.term_to_binary(binary)
      {:error, _} -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    create_deck()
    |> shuffle()
    |> deal(hand_size)
  end
end
