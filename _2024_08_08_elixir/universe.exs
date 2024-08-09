defmodule Universe do
    def big_bang do
        IO.puts("Big Bang #")
        Process.sleep(1000)
        expand()
    end
    def expand(state \\ 0) do
        IO.puts("Size of the universe is: #{state}")
        Process.sleep(1000)
        expand(state + 1)
    end
    def world(name) do
        IO.puts("Hello #{name}")
    end
end
