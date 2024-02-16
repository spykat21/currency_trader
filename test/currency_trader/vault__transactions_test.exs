defmodule CurrencyTrader.Vault_TransactionsTest do
  use CurrencyTrader.DataCase

  alias CurrencyTrader.Vault_Transactions

  describe "vault_transactions" do
    alias CurrencyTrader.Vault_Transactions.Vault_Transaction

    import CurrencyTrader.Vault_TransactionsFixtures

    @invalid_attrs %{type: nil, datetime: nil, currency_code: nil, amount: nil}

    test "list_vault_transactions/0 returns all vault_transactions" do
      vault__transaction = vault__transaction_fixture()
      assert Vault_Transactions.list_vault_transactions() == [vault__transaction]
    end

    test "get_vault__transaction!/1 returns the vault__transaction with given id" do
      vault__transaction = vault__transaction_fixture()

      assert Vault_Transactions.get_vault__transaction!(vault__transaction.id) ==
               vault__transaction
    end

    test "create_vault__transaction/1 with valid data creates a vault__transaction" do
      valid_attrs = %{
        type: "some type",
        datetime: ~U[2024-02-14 17:42:00Z],
        currency_code: "some currency_code",
        amount: "120.5"
      }

      assert {:ok, %Vault_Transaction{} = vault__transaction} =
               Vault_Transactions.create_vault__transaction(valid_attrs)

      assert vault__transaction.type == "some type"
      assert vault__transaction.datetime == ~U[2024-02-14 17:42:00Z]
      assert vault__transaction.currency_code == "some currency_code"
      assert vault__transaction.amount == Decimal.new("120.5")
    end

    test "create_vault__transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Vault_Transactions.create_vault__transaction(@invalid_attrs)
    end

    test "update_vault__transaction/2 with valid data updates the vault__transaction" do
      vault__transaction = vault__transaction_fixture()

      update_attrs = %{
        type: "some updated type",
        datetime: ~U[2024-02-15 17:42:00Z],
        currency_code: "some updated currency_code",
        amount: "456.7"
      }

      assert {:ok, %Vault_Transaction{} = vault__transaction} =
               Vault_Transactions.update_vault__transaction(vault__transaction, update_attrs)

      assert vault__transaction.type == "some updated type"
      assert vault__transaction.datetime == ~U[2024-02-15 17:42:00Z]
      assert vault__transaction.currency_code == "some updated currency_code"
      assert vault__transaction.amount == Decimal.new("456.7")
    end

    test "update_vault__transaction/2 with invalid data returns error changeset" do
      vault__transaction = vault__transaction_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Vault_Transactions.update_vault__transaction(vault__transaction, @invalid_attrs)

      assert vault__transaction ==
               Vault_Transactions.get_vault__transaction!(vault__transaction.id)
    end

    test "delete_vault__transaction/1 deletes the vault__transaction" do
      vault__transaction = vault__transaction_fixture()

      assert {:ok, %Vault_Transaction{}} =
               Vault_Transactions.delete_vault__transaction(vault__transaction)

      assert_raise Ecto.NoResultsError, fn ->
        Vault_Transactions.get_vault__transaction!(vault__transaction.id)
      end
    end

    test "change_vault__transaction/1 returns a vault__transaction changeset" do
      vault__transaction = vault__transaction_fixture()
      assert %Ecto.Changeset{} = Vault_Transactions.change_vault__transaction(vault__transaction)
    end
  end
end
