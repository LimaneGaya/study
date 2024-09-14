import Config

http_port =
  if config_env() != :test,
    do: System.get_env("TODO_HTTP_PORT", "5454"),
    else: System.get_env("TODO_TEST_HTTP_PORT", "5455")

config :todo, http_port: String.to_integer(http_port)

database_folder =
  if config_env() != :test,
    do: System.get_env("DATABASE_FOLDER", "database"),
    else: System.get_env("DATABASE_TEST_FOLDER", "database_test")
config :todo, :database, db_folder: database_folder

todo_server_expiry =
  if config_env() != :dev,
    do: System.get_env("TODO_SERVER_EXPIRY", "180"),
    else: System.get_env("TODO_SERVER_EXPIRY", "60")

config :todo, todo_server_expiry: :timer.seconds(String.to_integer(todo_server_expiry))
