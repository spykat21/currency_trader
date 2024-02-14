defmodule CurrencyTrader.TransactionsTest do
  use CurrencyTrader.DataCase

  alias CurrencyTrader.Transactions

  describe "transactions" do
    alias CurrencyTrader.Transactions.Transaction

    import CurrencyTrader.TransactionsFixtures

    @invalid_attrs %{action: nil, currency_code: nil, rate: nil, customer_name: nil, customer_phone: nil, amount: nil, date_time: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Transactions.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Transactions.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{action: "some action", currency_code: "some currency_code", rate: "120.5", customer_name: "some customer_name", customer_phone: "some customer_phone", amount: "120.5", date_time: ~U[2024-02-13 09:52:00Z]}

      assert {:ok, %Transaction{} = transaction} = Transactions.create_transaction(valid_attrs)
      assert transaction.action == "some action"
      assert transaction.currency_code == "some currency_code"
      assert transaction.rate == Decimal.new("120.5")
      assert transaction.customer_name == "some customer_name"
      assert transaction.customer_phone == "some customer_phone"
      assert transaction.amount == Decimal.new("120.5")
      assert transaction.date_time == ~U[2024-02-13 09:52:00Z]
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{action: "some updated action", currency_code: "some updated currency_code", rate: "456.7", customer_name: "some updated customer_name", customer_phone: "some updated customer_phone", amount: "456.7", date_time: ~U[2024-02-14 09:52:00Z]}

      assert {:ok, %Transaction{} = transaction} = Transactions.update_transaction(transaction, update_attrs)
      assert transaction.action == "some updated action"
      assert transaction.currency_code == "some updated currency_code"
      assert transaction.rate == Decimal.new("456.7")
      assert transaction.customer_name == "some updated customer_name"
      assert transaction.customer_phone == "some updated customer_phone"
      assert transaction.amount == Decimal.new("456.7")
      assert transaction.date_time == ~U[2024-02-14 09:52:00Z]
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_transaction(transaction, @invalid_attrs)
      assert transaction == Transactions.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Transactions.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Transactions.change_transaction(transaction)
    end
  end
end
