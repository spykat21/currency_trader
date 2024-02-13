defmodule CurrencyTrader.AgentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CurrencyTrader.Agents` context.
  """

  @doc """
  Generate a agent.
  """
  def agent_fixture(attrs \\ %{}) do
    {:ok, agent} =
      attrs
      |> Enum.into(%{
        hash_password: "some hash_password",
        name: "some name",
        username: "some username"
      })
      |> CurrencyTrader.Agents.create_agent()

    agent
  end
end
