defmodule Stats.Central.Median do
  require Integer
  alias Stats.Errors
  alias Stats.Validators
  def median(nums) when is_list(nums) do
    nums |> Validators.validate_num_list() |> calc_median()
  end
  def median(_),do: Errors.invalid_data_type()
  defp calc_median({:error, _msg}), do: Errors.invalid_data_type()
  defp calc_median({false, _}), do: Errors.invalid_data_type()
  defp calc_median({true, nums}) do
    count = Enum.count(nums)
    nums |> Enum.sort() |> get_median(Integer.is_even(count), count)
  end
  defp get_median(list, false, count), do: Enum.at(list, div(count, 2))
  defp get_median(list, true, count) do
    a = Enum.at(list, div(count - 1, 2))
    b = Enum.at(list, div(count, 2))
    (a + b) / 2
  end
end
