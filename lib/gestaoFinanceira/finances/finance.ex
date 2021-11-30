defmodule GestaoFinanceira.Finances.Finance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "finances" do
    field :created_at, :naive_datetime
    field :title, :string
    field :value, :decimal
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(finance, attrs) do
    finance
    |> cast(attrs, [:title, :value, :created_at])
    |> validate_required([:title, :value, :created_at])
  end
end
