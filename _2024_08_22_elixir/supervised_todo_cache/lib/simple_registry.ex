defmodule SimpleRegistry do
  use GenServer

  @table :mytable

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl GenServer
  def init(_) do
    Process.flag(:trap_exit, true)
    :ets.new(@table, [:named_table, :public, read_concurrency: true, write_concurrency: true])
    {:ok, nil}
  end

  @spec register(term()) :: :ok | :error
  def register(name) do
    Process.link(Process.whereis(__MODULE__))

    if :ets.insert_new(@table, {name, self()}) do
      :ok
    else
      :error
    end
  end

  @spec whereis(term()) :: pid() | [term()]
  def whereis(name) do
    case :ets.lookup(@table, name) do
      [{^name, pid}] -> pid
      [] -> nil
    end
  end

  @impl GenServer
  def handle_info({:EXIT, pid, _}, state) do
    :ets.match_delete(@table, {:_, pid})
    {:noreply, state}
  end
end
