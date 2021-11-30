defmodule GestaoFinanceiraWeb.FinanceController do
  use GestaoFinanceiraWeb, :controller

  alias GestaoFinanceira.Finances
  alias GestaoFinanceira.Finances.Finance

  def index(conn, _params) do
    finances = Finances.list_finances()
    render(conn, "index.html", finances: finances)
  end

  def new(conn, _params) do
    changeset = Finances.change_finance(%Finance{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"finance" => finance_params}) do
    current_user = conn.assigns.current_user

    changeset = Ecto.build_assoc(current_user, :finances, finance_params)
    IO.inspect("----------------------------")
    IO.inspect(current_user.id)
    IO.inspect("----------------------------")
    IO.inspect("----------------------------")
    IO.inspect(finance_params)
    IO.inspect("----------------------------")
    # changeset = Finance.changeset(%Finance{user_id: current_user.id}, finance_params)
    # IO.inspect("----------------------------")
    # IO.inspect(changeset)
    # IO.inspect("----------------------------")

    case Finances.create_finance(changeset) do
      {:ok, finance} ->
        conn
        |> put_flash(:info, "Finance created successfully.")
        |> redirect(to: Routes.finance_path(conn, :show, finance))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    finance = Finances.get_finance!(id)
    render(conn, "show.html", finance: finance)
  end

  def edit(conn, %{"id" => id}) do
    finance = Finances.get_finance!(id)
    changeset = Finances.change_finance(finance)
    render(conn, "edit.html", finance: finance, changeset: changeset)
  end

  def update(conn, %{"id" => id, "finance" => finance_params}) do
    finance = Finances.get_finance!(id)

    case Finances.update_finance(finance, finance_params) do
      {:ok, finance} ->
        conn
        |> put_flash(:info, "Finance updated successfully.")
        |> redirect(to: Routes.finance_path(conn, :show, finance))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", finance: finance, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    finance = Finances.get_finance!(id)
    {:ok, _finance} = Finances.delete_finance(finance)

    conn
    |> put_flash(:info, "Finance deleted successfully.")
    |> redirect(to: Routes.finance_path(conn, :index))
  end
end
