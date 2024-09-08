defmodule SimpleRegistry do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl GenServer
  def init(_) do
    Process.flag(:trap_exit, true)
    {:ok, %{}}
  end

  @spec register(pid(), term()) :: :ok
  def register(pid, name) do
    GenServer.cast(__MODULE__, {:register, pid, name})
  end

  @spec whereis(term()) :: pid() | nil
  def whereis(name) do
    GenServer.call(__MODULE__, {:whereis, name})
  end

  @impl GenServer
  def handle_cast({:register, pid, name}, state) do
    Process.link(pid)
    {:noreply, Map.put(state, name, pid)}
  end

  @impl GenServer
  def handle_call({:whereis, name}, _, state) do
    case Map.fetch(state, name) do
      {:ok, pid} -> {:reply, pid, state}
      :error -> {:reply, nil, state}
    end
  end

  @impl GenServer
  def handle_info({:EXIT, pid, :normal}, state) do
    map = Map.filter(state, fn {_, value} -> value == pid end) |> Map.keys()
    {:noreply, Map.drop(state, map)}
  end
end
