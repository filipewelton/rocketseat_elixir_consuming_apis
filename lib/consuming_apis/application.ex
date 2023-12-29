defmodule ConsumingApis.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ConsumingApisWeb.Telemetry,
      ConsumingApis.Repo,
      {DNSCluster, query: Application.get_env(:consuming_apis, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ConsumingApis.PubSub},
      # Start a worker by calling: ConsumingApis.Worker.start_link(arg)
      # {ConsumingApis.Worker, arg},
      # Start to serve requests, typically the last entry
      ConsumingApisWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ConsumingApis.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ConsumingApisWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
