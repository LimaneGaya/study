defmodule Tutorials.Structs.SevenWonders do
  defstruct(name: "", country: "")
  alias Tutorials.Structs.SevenWonders
  @type t :: %SevenWonders{
    name: String.t(),
    country: String.t()
  }
  #--------------- all --------------------
  @spec all :: list(t())
  def all() do
    [
      %SevenWonders{name: "Taj mahal", country: "India"},
      %SevenWonders{name: "Great Wall of China", country: "China"}
    ]
  end
  #----------------------------------------
  @spec print_names(list(t())) :: :ok
  def print_names(wonders) do
    wonders |> Enum.each(fn %{name: name} -> IO.puts(name) end)
  end

  @spec filter_by_country(list(t()), String.t()) :: :ok
  def filter_by_country(wonders, country) do
    Enum.filter(wonders, fn %{country: count} -> count == country end) |> print_names
  end

  @spec in_countries_starting_with_i(list(t())) :: :ok
  def in_countries_starting_with_i(wonders) do
    Enum.filter(wonders, fn %{country: count} -> String.starts_with?(count, "i") end) |> print_names
  end
  @spec sort_by_country_length(list(t())) :: list()
  def sort_by_country_length(wonders) do
    wonders |> Enum.sort(fn x, y -> String.length(x.country) < String.length(y.country) end)
  end
  @spec name_country_list(list(t())) :: list()
  def name_country_list(wonders) do
    Enum.reduce(wonders, [], fn x, acc -> [[x.name, x.country] | acc] end)
  end
  @spec country_name_keyword_list(list(t())) :: list()
  def country_name_keyword_list(wonders) do
    Enum.reduce(wonders, [], fn wonder, acc -> [{String.to_atom(wonder.country), wonder.name} | acc] end)
  end
  @spec all_names(list(t())) :: any()
  def all_names(wonders) do
    for %{name: name} <- wonders, do: name
  end
end
