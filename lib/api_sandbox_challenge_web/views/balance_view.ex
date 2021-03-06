defmodule ApiSandboxChallengeWeb.BalanceView do
  use ApiSandboxChallengeWeb, :view
  alias ApiSandboxChallengeWeb.BalanceView

  def render("index.json", %{balances: balances}) do
    render_many(balances, BalanceView, "balance.json")
  end

  def render("show.json", %{balance: balance}) do
    render_one(balance, BalanceView, "balance.json")
  end

  def render("balance.json", %{balance: balance}) do
    %{
      account_id: balance.account_id,
      available: balance.available,
      ledger: balance.ledger,
      links: balance.links
    }
  end
end
