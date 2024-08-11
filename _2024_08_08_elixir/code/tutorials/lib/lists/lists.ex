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


  #------ Reverse List ------
  @spec reverse(list(), list()) :: list()
  def reverse(list, new \\ [])
  def reverse([], new), do: new
  @doc """
  Reverse a list of elements
  """
  def reverse([h | t], new), do: reverse(t, [h | new])


  #------- Map --------
  @spec map(list(), function(), list()) :: list()
  def map(elem, func, acc \\ [])
  def map([], _, acc), do: reverse(acc)
  def map([h | t], func, acc), do: map(t, func, [func.(h) | acc])

  #------- Concat -------
  @spec concat(list(), list()) :: list()
  def concat(list1, list2), do: concat_imp(reverse(list1), list2)
  defp concat_imp([], list2), do: list2
  defp concat_imp([h | t], list2), do: concat_imp(t, [h | list2])

  #------- FlatMap ------
  @spec flat_map(list(), (any() -> list()), list()) :: list()
  def flat_map(element, func, acc \\ [] )
  def flat_map([], _, acc), do: acc
  def flat_map([h | t], func, acc), do: flat_map(t, func, concat(acc, func.(h)));
end
