defmodule Todo.CacheTest do
  use ExUnit.Case
  test "server_process" do
    bob_pid = Todo.Cache.server_process("bob")
    assert bob_pid != Todo.Cache.server_process("alice")
    assert bob_pid == Todo.Cache.server_process("bob")
    end
  test "to-do operations" do
    {:ok, cache} = Todo.Cache.start()
    alice = Todo.Cache.server_process(cache, "alice")
    Todo.Server.add_entry(alice, %{date: ~D[2023-12-19], title: "Dentist"})
    entries = Todo.Server.entries(alice, ~D[2023-12-19])
    assert [%{date: ~D[2023-12-19], title: "Dentist"}] = entries
  end

end
