defmodule Tutorials.Structs.Expense do
  alias Tutorials.Structs.Expense
  defstruct(
    title: "",
    date: nil,
    amount: 0,
    store: ""
  )
  @type t :: %Expense{
    title: String.t(),
    date: Date.t() | nil,
    amount: number(),
    store: String.t()
  }
  @spec sample :: list(t())
  def sample do
    [
      %Expense{title: "Grocery", date: ~D[2023-06-30], amount: 18.99, store: "Nike"},
      %Expense{title: "Games", date: ~D[2024-01-01], amount: 60.50, store: "God of war 3"},
      %Expense{title: "Gym", date: ~D[2024-01-02], amount: 60.50, store: "Gym"},
      %Expense{title: "TV", date: ~D[2024-01-05], amount: 14.99, store: "Netflix"},
      %Expense{title: "Books", date: ~D[2024-02-10], amount: 70.99, store: "Books"}
    ]
  end

  @spec total(list(t())) :: number()
  def total(expense) do
    Enum.reduce(expense, 0, fn x, acc -> x.amount + acc end)
  end
  @spec sort_by_date(list(t())) :: list(t())
  def sort_by_date(expense) do
    Enum.sort_by(expense, &(&1.date))
  end
  @spec add_expense(t()) :: list(t())
  def add_expense(%Expense{} = expense) do
     [expense | sample()]
  end

  @spec update_amount(String.t(), number()) :: list(t())
  def update_amount(title, amount) do
    [item] = Enum.filter(sample(), fn %{title: expense_title} -> expense_title == title end)
    new_item = %{item | amount: amount}
    [new_item | sample() |> List.delete(item)]
  end
  #------------- With --------------
  @users ["Coco", "Cece", "Louis", "Chiko"]
  def authenticate(user) when user in @users, do: {:ok, "authorized"}
  def authenticate(_), do: {:error, "unauthorized"}
  def verify_password(user, _password) when user in @users, do: {:ok, "password verified"}
  def verity_password(_user, _password), do: {:error, "wrong password"}
  def login(user, password) do
    with {:ok, _auth_msg} <- authenticate(user),
    {:ok, _msg} <- verify_password(user, password) do
      {:ok, "#{user} logged in successfully"}
    else
      {:error, msg} -> {:error, msg}
      _ -> :unauthorized
    end
  end

end
