defmodule Plugs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PlugsWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:plugs, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Plugs.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Plugs.Finch},
      # Start a worker by calling: Plugs.Worker.start_link(arg)
      # {Plugs.Worker, arg},
      # Start to serve requests, typically the last entry
      PlugsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Plugs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PlugsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
