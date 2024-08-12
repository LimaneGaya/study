defmodule Stats.Central.Mean do
  alias Stats.Errors
  alias Stats.Validators
  def population_mean([]), do: Errors.invalid_data_type()
  def population_mean(nums) when is_list(nums) do
    nums |> Validators.validate_num_list |> calculate_population_mean
  end
  def population_mean(_), do: Errors.invalid_data_type()

  def calculate_population_mean({false, _}), do: Errors.invalid_data_type()
  def calculate_population_mean({true, nums}) do
    nums |> Enum.sum |> mean(Enum.count(nums))
  end
  def mean(sigma, count), do: sigma / count
end
