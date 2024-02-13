defmodule CurrencyTrader.Repo do
  use Ecto.Repo,
    otp_app: :currency_trader,
    adapter: Ecto.Adapters.Postgres
end
