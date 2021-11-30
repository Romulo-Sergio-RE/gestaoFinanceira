defmodule GestaoFinanceira.FinancesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GestaoFinanceira.Finances` context.
  """

  @doc """
  Generate a finance.
  """
  def finance_fixture(attrs \\ %{}) do
    {:ok, finance} =
      attrs
      |> Enum.into(%{
        created_at: ~N[2021-11-28 21:37:00],
        title: "some title",
        value: "120.5"
      })
      |> GestaoFinanceira.Finances.create_finance()

    finance
  end
end
