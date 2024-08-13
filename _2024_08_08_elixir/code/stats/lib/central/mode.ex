defmodule Stats.Central.Mode do
  alias Stats.Errors
  @spec mode(list(number())) :: list(number())
  def mode(list) when is_list(list) do
    max = list |> Enum.frequencies() |> Map.values() |> Enum.max()
    list
    |> Enum.frequencies()
    |> Map.filter(fn {_, value} -> value == max end)
    |> Map.keys()
  end
  def mode(_), do: Errors.invalid_data_type()
end
