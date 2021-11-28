defmodule ApiSandboxChallengeWeb.TransactionController do
  use ApiSandboxChallengeWeb, :controller

  alias ApiSandboxChallenge.Management
  alias ApiSandboxChallenge.Management.Transaction

  action_fallback ApiSandboxChallengeWeb.FallbackController

  def index(conn, %{"id" => id}) do
    transactions = Management.list_transactions!(id)
    render(conn, "index.json", transactions: transactions)
  end

  def show(conn, %{"id" => id, "transaction_id" => transaction_id}) do
    transaction = Management.get_transaction!(id, transaction_id)
    render(conn, "show.json", transaction: transaction)
  end

end
