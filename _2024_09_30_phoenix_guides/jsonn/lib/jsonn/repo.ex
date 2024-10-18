defmodule Jsonn.Repo do
  use Ecto.Repo,
    otp_app: :jsonn,
    adapter: Ecto.Adapters.SQLite3
end
