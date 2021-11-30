defmodule GestaoFinanceiraWeb.FinanceControllerTest do
  use GestaoFinanceiraWeb.ConnCase

  import GestaoFinanceira.FinancesFixtures

  @create_attrs %{created_at: ~N[2021-11-28 21:37:00], title: "some title", value: "120.5"}
  @update_attrs %{created_at: ~N[2021-11-29 21:37:00], title: "some updated title", value: "456.7"}
  @invalid_attrs %{created_at: nil, title: nil, value: nil}

  describe "index" do
    test "lists all finances", %{conn: conn} do
      conn = get(conn, Routes.finance_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Finances"
    end
  end

  describe "new finance" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.finance_path(conn, :new))
      assert html_response(conn, 200) =~ "New Finance"
    end
  end

  describe "create finance" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.finance_path(conn, :create), finance: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.finance_path(conn, :show, id)

      conn = get(conn, Routes.finance_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Finance"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.finance_path(conn, :create), finance: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Finance"
    end
  end

  describe "edit finance" do
    setup [:create_finance]

    test "renders form for editing chosen finance", %{conn: conn, finance: finance} do
      conn = get(conn, Routes.finance_path(conn, :edit, finance))
      assert html_response(conn, 200) =~ "Edit Finance"
    end
  end

  describe "update finance" do
    setup [:create_finance]

    test "redirects when data is valid", %{conn: conn, finance: finance} do
      conn = put(conn, Routes.finance_path(conn, :update, finance), finance: @update_attrs)
      assert redirected_to(conn) == Routes.finance_path(conn, :show, finance)

      conn = get(conn, Routes.finance_path(conn, :show, finance))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, finance: finance} do
      conn = put(conn, Routes.finance_path(conn, :update, finance), finance: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Finance"
    end
  end

  describe "delete finance" do
    setup [:create_finance]

    test "deletes chosen finance", %{conn: conn, finance: finance} do
      conn = delete(conn, Routes.finance_path(conn, :delete, finance))
      assert redirected_to(conn) == Routes.finance_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.finance_path(conn, :show, finance))
      end
    end
  end

  defp create_finance(_) do
    finance = finance_fixture()
    %{finance: finance}
  end
end
