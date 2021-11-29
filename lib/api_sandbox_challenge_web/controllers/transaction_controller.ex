defmodule ApiSandboxChallengeWeb.TransactionController do
  use ApiSandboxChallengeWeb, :controller

  alias ApiSandboxChallenge.Management
  alias ApiSandboxChallenge.Management.Transaction

  action_fallback ApiSandboxChallengeWeb.FallbackController

  def index(conn, %{"id" => account_id, "username" => username}) do
    seed = Management.parse_token(username)
    transactions = Management.list_transactions!(account_id, seed)
    render(conn, "index.json", transactions: transactions)
  end

  def show(conn, %{"id" => id, "transaction_id" => transaction_id, "username" => username}) do
    seed = Management.parse_token(username)
    transaction = Management.get_transaction!(id, transaction_id, seed)
    render(conn, "show.json", transaction: transaction)
  end

end
