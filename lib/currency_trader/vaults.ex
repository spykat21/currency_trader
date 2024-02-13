defmodule CurrencyTrader.Vaults do
  @moduledoc """
  The Vaults context.
  """

  import Ecto.Query, warn: false
  alias CurrencyTrader.Repo

  alias CurrencyTrader.Vaults.Vault

  @doc """
  Returns the list of vaults.

  ## Examples

      iex> list_vaults()
      [%Vault{}, ...]

  """
  def list_vaults do
    Repo.all(Vault)
  end

  @doc """
  Gets a single vault.

  Raises `Ecto.NoResultsError` if the Vault does not exist.

  ## Examples

      iex> get_vault!(123)
      %Vault{}

      iex> get_vault!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vault!(id), do: Repo.get!(Vault, id)

  @doc """
  Creates a vault.

  ## Examples

      iex> create_vault(%{field: value})
      {:ok, %Vault{}}

      iex> create_vault(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vault(agent, attrs \\ %{}) do
    agent
    |> Ecto.build_assoc(:vault)
    |> Vault.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vault.

  ## Examples

      iex> update_vault(vault, %{field: new_value})
      {:ok, %Vault{}}

      iex> update_vault(vault, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vault(%Vault{} = vault, attrs) do
    vault
    |> Vault.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a vault.

  ## Examples

      iex> delete_vault(vault)
      {:ok, %Vault{}}

      iex> delete_vault(vault)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vault(%Vault{} = vault) do
    Repo.delete(vault)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vault changes.

  ## Examples

      iex> change_vault(vault)
      %Ecto.Changeset{data: %Vault{}}

  """
  def change_vault(%Vault{} = vault, attrs \\ %{}) do
    Vault.changeset(vault, attrs)
  end
end
