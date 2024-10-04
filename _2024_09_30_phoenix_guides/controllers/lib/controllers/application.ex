defmodule Controllers.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ControllersWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:controllers, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Controllers.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Controllers.Finch},
      # Start a worker by calling: Controllers.Worker.start_link(arg)
      # {Controllers.Worker, arg},
      # Start to serve requests, typically the last entry
      ControllersWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Controllers.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ControllersWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
