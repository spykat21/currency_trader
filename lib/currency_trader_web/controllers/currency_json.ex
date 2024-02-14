defmodule CurrencyTraderWeb.CurrencyJSON do
  alias CurrencyTrader.Currencies.Currency

  @doc """
  Renders a list of currencies.
  """
  def index(%{currencies: currencies}) do
    %{data: for(currency <- currencies, do: data(currency))}
  end

  @doc """
  Renders a single currency.
  """
  def show(%{currency: currency}) do
    %{data: data(currency)}
  end

  def data(%Currency{} = currency) do
    %{
      id: currency.id,
      currency_code: currency.curr_code,
      currency: currency.currency,
      buy_rate: currency.buy_rate,
      sell_rate: currency.sell_rate,
      updated_by: currency.updated_by
    }
  end
end
