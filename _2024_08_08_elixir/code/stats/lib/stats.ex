defmodule Stats do
  alias Stats.Central.{Mean, Median, Mode}

  #def population_mean(nums), do: Mean.population_mean(nums)
  defdelegate population_mean(nums), to: Mean
  defdelegate median(nums), to: Median
  defdelegate mode(nums), to: Mode

end
