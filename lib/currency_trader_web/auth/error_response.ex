defmodule CurrencyTraderWeb.Auth.ErrorResponse.Unauthorized do
  defexception message: "Unauthorized", plug_status: 401
end

defmodule CurrencyTraderWeb.Auth.ErrorResponse.Unprocessable do
  defexception message: "Unprocessable ", plug_status: 422
end
