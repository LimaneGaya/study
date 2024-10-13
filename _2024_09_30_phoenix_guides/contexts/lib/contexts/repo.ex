defmodule Contexts.Repo do
  use Ecto.Repo,
    otp_app: :contexts,
    adapter: Ecto.Adapters.SQLite3
end
