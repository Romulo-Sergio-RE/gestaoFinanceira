defmodule GestaoFinanceiraWeb.PageController do
  use GestaoFinanceiraWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
