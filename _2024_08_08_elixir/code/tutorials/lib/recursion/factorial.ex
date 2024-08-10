defmodule Tutorials.Recursion.Factorial do
  def factorial(num, fac \\ 1)
  def factorial(1, fac), do: fac
  def factorial(num, fac), do: factorial(num - 1, fac * num)
end
