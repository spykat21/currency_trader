defmodule CurrencyTraderWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,otp_app: :currency_trader,
  module: CurrencyTraderWeb.Auth.Guardian,
  error_handler: CurrencyTraderWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
