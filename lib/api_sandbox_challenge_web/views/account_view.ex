defmodule ApiSandboxChallengeWeb.AccountView do
  use ApiSandboxChallengeWeb, :view
  alias ApiSandboxChallengeWeb.AccountView

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, AccountView, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    %{
      id: account.id,
      currency: account.currency,
      enrollment_id: account.enrollment_id,
      institution: account.institution,
      last_four: account.last_four,
      links: account.links,
      name: account.name,
      subtype: account.subtype,
      type: account.type
    }
  end
end
