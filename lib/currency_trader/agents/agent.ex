defmodule CurrencyTrader.Agents.Agent do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "agents" do
    field :name, :string
    field :username, :string
    field :hash_password, :string
    has_many :vaults, CurrencyTrader.Vaults.Vault
    has_many :transactions, CurrencyTrader.Transactions.Transaction

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(agent, attrs) do
    agent
    |> cast(attrs, [:name, :username, :hash_password])
    |> validate_required([:name, :username, :hash_password])
    |> validate_length(:username, min: 3, message: "min length is 3")
    |> validate_length(:username, max: 5, message: "max length is 5")
    |> unique_constraint(:username)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{hash_password: hash_password}} = changeset
       ) do
    change(changeset, hash_password: Bcrypt.hash_pwd_salt(hash_password))
  end

  defp put_password_hash(changeset), do: changeset
end
