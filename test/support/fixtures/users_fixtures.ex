defmodule CurrencyTrader.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CurrencyTrader.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> CurrencyTrader.Users.create_user()

    user
  end
end
