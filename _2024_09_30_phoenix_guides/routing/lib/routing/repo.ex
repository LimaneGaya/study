defmodule Routing.Repo do
  use Ecto.Repo,
    otp_app: :routing,
    adapter: Ecto.Adapters.SQLite3
end
