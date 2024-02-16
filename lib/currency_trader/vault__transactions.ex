defmodule CurrencyTrader.Vault_Transactions do
  @moduledoc """
  The Vault_Transactions context.
  """

  import Ecto.Query, warn: false
  alias CurrencyTrader.Repo

  alias CurrencyTrader.Vault_Transactions.Vault_Transaction

  @doc """
  Returns the list of vault_transactions.

  ## Examples

      iex> list_vault_transactions()
      [%Vault_Transaction{}, ...]

  """
  def list_vault_transactions do
    Repo.all(Vault_Transaction)
  end

  @doc """
  Gets a single vault__transaction.

  Raises `Ecto.NoResultsError` if the Vault  transaction does not exist.

  ## Examples

      iex> get_vault__transaction!(123)
      %Vault_Transaction{}

      iex> get_vault__transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vault__transaction!(id), do: Repo.get!(Vault_Transaction, id)

  @doc """
  Creates a vault__transaction.

  ## Examples

      iex> create_vault__transaction(%{field: value})
      {:ok, %Vault_Transaction{}}

      iex> create_vault__transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vault__transaction(transaction, attrs \\ %{}) do
    transaction
    |> Ecto.build_assoc(:vault_transactions)
    |> Vault_Transaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vault__transaction.

  ## Examples

      iex> update_vault__transaction(vault__transaction, %{field: new_value})
      {:ok, %Vault_Transaction{}}

      iex> update_vault__transaction(vault__transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vault__transaction(%Vault_Transaction{} = vault__transaction, attrs) do
    vault__transaction
    |> Vault_Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a vault__transaction.

  ## Examples

      iex> delete_vault__transaction(vault__transaction)
      {:ok, %Vault_Transaction{}}

      iex> delete_vault__transaction(vault__transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vault__transaction(%Vault_Transaction{} = vault__transaction) do
    Repo.delete(vault__transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vault__transaction changes.

  ## Examples

      iex> change_vault__transaction(vault__transaction)
      %Ecto.Changeset{data: %Vault_Transaction{}}

  """
  def change_vault__transaction(%Vault_Transaction{} = vault__transaction, attrs \\ %{}) do
    Vault_Transaction.changeset(vault__transaction, attrs)
  end
end
