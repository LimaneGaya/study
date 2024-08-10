defmodule Tutorials.Recursion.PrintDigits do
  def upto(0), do: 0
  def upto(num) do
    upto(num - 1)
    IO.puts(num)
  end
  def downto(0), do: 0
  def downto(num) do
    IO.puts(num)
    downto(num - 1)
  end
end
