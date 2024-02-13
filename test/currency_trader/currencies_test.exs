defmodule CurrencyTrader.CurrenciesTest do
  use CurrencyTrader.DataCase

  alias CurrencyTrader.Currencies

  describe "currencies" do
    alias CurrencyTrader.Currencies.Currency

    import CurrencyTrader.CurrenciesFixtures

    @invalid_attrs %{currency: nil, buy_rate: nil, sell_rate: nil, updated_by: nil}

    test "list_currencies/0 returns all currencies" do
      currency = currency_fixture()
      assert Currencies.list_currencies() == [currency]
    end

    test "get_currency!/1 returns the currency with given id" do
      currency = currency_fixture()
      assert Currencies.get_currency!(currency.id) == currency
    end

    test "create_currency/1 with valid data creates a currency" do
      valid_attrs = %{
        currency: "some currency",
        buy_rate: "120.5",
        sell_rate: "120.5",
        updated_by: "some updated_by"
      }

      assert {:ok, %Currency{} = currency} = Currencies.create_currency(valid_attrs)
      assert currency.currency == "some currency"
      assert currency.buy_rate == Decimal.new("120.5")
      assert currency.sell_rate == Decimal.new("120.5")
      assert currency.updated_by == "some updated_by"
    end

    test "create_currency/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Currencies.create_currency(@invalid_attrs)
    end

    test "update_currency/2 with valid data updates the currency" do
      currency = currency_fixture()

      update_attrs = %{
        currency: "some updated currency",
        buy_rate: "456.7",
        sell_rate: "456.7",
        updated_by: "some updated updated_by"
      }

      assert {:ok, %Currency{} = currency} = Currencies.update_currency(currency, update_attrs)
      assert currency.currency == "some updated currency"
      assert currency.buy_rate == Decimal.new("456.7")
      assert currency.sell_rate == Decimal.new("456.7")
      assert currency.updated_by == "some updated updated_by"
    end

    test "update_currency/2 with invalid data returns error changeset" do
      currency = currency_fixture()
      assert {:error, %Ecto.Changeset{}} = Currencies.update_currency(currency, @invalid_attrs)
      assert currency == Currencies.get_currency!(currency.id)
    end

    test "delete_currency/1 deletes the currency" do
      currency = currency_fixture()
      assert {:ok, %Currency{}} = Currencies.delete_currency(currency)
      assert_raise Ecto.NoResultsError, fn -> Currencies.get_currency!(currency.id) end
    end

    test "change_currency/1 returns a currency changeset" do
      currency = currency_fixture()
      assert %Ecto.Changeset{} = Currencies.change_currency(currency)
    end
  end
end
