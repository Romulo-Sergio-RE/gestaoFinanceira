defmodule GestaoFinanceira.Repo do
  use Ecto.Repo,
    otp_app: :gestaoFinanceira,
    adapter: Ecto.Adapters.Postgres
end
