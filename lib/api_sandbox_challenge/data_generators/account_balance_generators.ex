defmodule ApiSandboxChallenge.DataGenerators.AccountBalanceGenerators do

  alias ApiSandboxChallenge.DataGenerators.GlobalGenerators
  alias ApiSandboxChallenge.DataGenerators.AccountGenerators

  def generate_running_balance(seed, account_id, count \\ 90, running_balance \\ "10000.0") do
    count = count - 1
    transaction_slice = AccountGenerators.generate_transaction_slice(seed, count, account_id, running_balance)
    running_balance = transaction_slice.running_balance
    if count <= 0 do
      running_balance
    else
      generate_running_balance(seed, account_id, count, running_balance)
    end
  end

  def generate_balance_details(account_id, seed) do
    available = generate_running_balance(seed, account_id)

    base_url = ApiSandboxChallengeWeb.Endpoint.url()

    %ApiSandboxChallenge.Management.Balance{
      account_id: account_id,
      available: available,
      ledger: "#{String.to_float(available) + 232.32}",
      links: %{
        account: "#{base_url}/accounts/#{account_id}?username=test_token_#{seed}",
        self: "#{base_url}/accounts/#{account_id}/balances?username=test_token_#{seed}"
      }
    }
  end



  # return account balance for a specific account
  def get_balance_details(seed, account_id) do
    generate_balance_details(account_id, seed)
  end
end
