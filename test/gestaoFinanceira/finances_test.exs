defmodule GestaoFinanceira.FinancesTest do
  use GestaoFinanceira.DataCase

  alias GestaoFinanceira.Finances

  describe "finances" do
    alias GestaoFinanceira.Finances.Finance

    import GestaoFinanceira.FinancesFixtures

    @invalid_attrs %{created_at: nil, title: nil, value: nil}

    test "list_finances/0 returns all finances" do
      finance = finance_fixture()
      assert Finances.list_finances() == [finance]
    end

    test "get_finance!/1 returns the finance with given id" do
      finance = finance_fixture()
      assert Finances.get_finance!(finance.id) == finance
    end

    test "create_finance/1 with valid data creates a finance" do
      valid_attrs = %{created_at: ~N[2021-11-28 21:37:00], title: "some title", value: "120.5"}

      assert {:ok, %Finance{} = finance} = Finances.create_finance(valid_attrs)
      assert finance.created_at == ~N[2021-11-28 21:37:00]
      assert finance.title == "some title"
      assert finance.value == Decimal.new("120.5")
    end

    test "create_finance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finances.create_finance(@invalid_attrs)
    end

    test "update_finance/2 with valid data updates the finance" do
      finance = finance_fixture()
      update_attrs = %{created_at: ~N[2021-11-29 21:37:00], title: "some updated title", value: "456.7"}

      assert {:ok, %Finance{} = finance} = Finances.update_finance(finance, update_attrs)
      assert finance.created_at == ~N[2021-11-29 21:37:00]
      assert finance.title == "some updated title"
      assert finance.value == Decimal.new("456.7")
    end

    test "update_finance/2 with invalid data returns error changeset" do
      finance = finance_fixture()
      assert {:error, %Ecto.Changeset{}} = Finances.update_finance(finance, @invalid_attrs)
      assert finance == Finances.get_finance!(finance.id)
    end

    test "delete_finance/1 deletes the finance" do
      finance = finance_fixture()
      assert {:ok, %Finance{}} = Finances.delete_finance(finance)
      assert_raise Ecto.NoResultsError, fn -> Finances.get_finance!(finance.id) end
    end

    test "change_finance/1 returns a finance changeset" do
      finance = finance_fixture()
      assert %Ecto.Changeset{} = Finances.change_finance(finance)
    end
  end
end
