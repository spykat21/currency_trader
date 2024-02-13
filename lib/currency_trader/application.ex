defmodule CurrencyTrader.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CurrencyTraderWeb.Telemetry,
      CurrencyTrader.Repo,
      {DNSCluster, query: Application.get_env(:currency_trader, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CurrencyTrader.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CurrencyTrader.Finch},
      # Start a worker by calling: CurrencyTrader.Worker.start_link(arg)
      # {CurrencyTrader.Worker, arg},
      # Start to serve requests, typically the last entry
      CurrencyTraderWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CurrencyTrader.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CurrencyTraderWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
