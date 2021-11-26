defmodule ApiSandboxChallengeWeb.TransactionController do
  use ApiSandboxChallengeWeb, :controller

  alias ApiSandboxChallenge.Management
  alias ApiSandboxChallenge.Management.Transaction

  action_fallback ApiSandboxChallengeWeb.FallbackController

  def index(conn, %{"id" => id}) do
    transactions = Management.list_transactions!(id)
    render(conn, "index.json", transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    with {:ok, %Transaction{} = transaction} <- Management.create_transaction(transaction_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.transaction_path(conn, :show, transaction))
      |> render("show.json", transaction: transaction)
    end
  end

  def show(conn, %{"id" => id, "transaction_id" => transaction_id}) do
    transaction = Management.get_transactions!(id, transaction_id)
    render(conn, "show.json", transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Management.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <- Management.update_transaction(transaction, transaction_params) do
      render(conn, "show.json", transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Management.get_transaction!(id)

    with {:ok, %Transaction{}} <- Management.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
