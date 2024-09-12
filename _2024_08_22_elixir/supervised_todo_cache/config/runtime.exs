import Config

http_port = System.get_env("TODO_HTTP_PORT", "5454")
config :todo, http_port: String.to_integer(http_port)
