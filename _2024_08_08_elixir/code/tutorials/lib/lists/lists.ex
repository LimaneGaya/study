defmodule Tutorials.Lists do
  @moduledoc """

  Function Summary:

  1. sum

  """

  @spec sum_simple(list(number())) :: number()
  def sum_simple([]), do: 0
  def sum_simple([h | t]) do
    h + sum_simple(t)
  end

  @spec sum(list(number()), integer()) :: number()
  def sum(nums, s \\ 0)
  def sum([], s), do: s
  @doc """
  Retturns the sum of the numbers in a List
  """
  def sum([h | t], s) do
    sum(t, s + h)
  end

end
