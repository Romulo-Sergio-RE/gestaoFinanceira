defmodule GestaoFinanceira.Repo.Migrations.CreateFinances do
  use Ecto.Migration

  def change do
    create table(:finances) do
      add :title, :string, null: false
      add :value, :decimal, null: false
      add :created_at, :naive_datetime
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:finances, [:user_id])
  end
end
