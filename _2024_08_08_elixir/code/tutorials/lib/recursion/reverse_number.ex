defmodule Tutorials.Recursion.ReverseNumber do
  def reverse(num, rev \\ 0)
  def reverse(0, rev), do: rev
  def reverse(num, rev) do
    newnum = div(num, 10)
    newrev = rev * 10 + rem(num, 10)
    reverse(newnum, newrev)
  end
end
