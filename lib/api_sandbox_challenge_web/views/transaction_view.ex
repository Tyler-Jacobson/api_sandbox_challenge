defmodule ApiSandboxChallengeWeb.TransactionView do
  use ApiSandboxChallengeWeb, :view
  alias ApiSandboxChallengeWeb.TransactionView

  def render("index.json", %{transactions: transactions}) do
    render_many(transactions, TransactionView, "transaction.json")
  end

  def render("show.json", %{transaction: transaction}) do
    render_one(transaction, TransactionView, "transaction.json")
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{
      transaction_id: transaction.transaction_id,
      account_id: transaction.account_id,
      amount: transaction.amount,
      date: transaction.date,
      description: transaction.description,
      details: transaction.details,
      links: transaction.links,
      running_balance: transaction.running_balance,
      status: transaction.status,
      type: transaction.type
    }
  end
end
