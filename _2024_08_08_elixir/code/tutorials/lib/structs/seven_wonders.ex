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
end
