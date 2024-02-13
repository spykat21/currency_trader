defmodule CurrencyTrader.AgentsTest do
  use CurrencyTrader.DataCase

  alias CurrencyTrader.Agents

  describe "agents" do
    alias CurrencyTrader.Agents.Agent

    import CurrencyTrader.AgentsFixtures

    @invalid_attrs %{name: nil, username: nil, hash_password: nil}

    test "list_agents/0 returns all agents" do
      agent = agent_fixture()
      assert Agents.list_agents() == [agent]
    end

    test "get_agent!/1 returns the agent with given id" do
      agent = agent_fixture()
      assert Agents.get_agent!(agent.id) == agent
    end

    test "create_agent/1 with valid data creates a agent" do
      valid_attrs = %{
        name: "some name",
        username: "some username",
        hash_password: "some hash_password"
      }

      assert {:ok, %Agent{} = agent} = Agents.create_agent(valid_attrs)
      assert agent.name == "some name"
      assert agent.username == "some username"
      assert agent.hash_password == "some hash_password"
    end

    test "create_agent/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Agents.create_agent(@invalid_attrs)
    end

    test "update_agent/2 with valid data updates the agent" do
      agent = agent_fixture()

      update_attrs = %{
        name: "some updated name",
        username: "some updated username",
        hash_password: "some updated hash_password"
      }

      assert {:ok, %Agent{} = agent} = Agents.update_agent(agent, update_attrs)
      assert agent.name == "some updated name"
      assert agent.username == "some updated username"
      assert agent.hash_password == "some updated hash_password"
    end

    test "update_agent/2 with invalid data returns error changeset" do
      agent = agent_fixture()
      assert {:error, %Ecto.Changeset{}} = Agents.update_agent(agent, @invalid_attrs)
      assert agent == Agents.get_agent!(agent.id)
    end

    test "delete_agent/1 deletes the agent" do
      agent = agent_fixture()
      assert {:ok, %Agent{}} = Agents.delete_agent(agent)
      assert_raise Ecto.NoResultsError, fn -> Agents.get_agent!(agent.id) end
    end

    test "change_agent/1 returns a agent changeset" do
      agent = agent_fixture()
      assert %Ecto.Changeset{} = Agents.change_agent(agent)
    end
  end
end
