defmodule ApiSandboxChallenge.DataGenerators.AccountBalanceGenerators do

  alias ApiSandboxChallenge.DataGenerators.AccountTransactionGenerators

  # generates a current running balance for the user
  def generate_running_balance(seed, account_id, count \\ 90, running_balance \\ "10000.0") do
    count = count - 1
    # makes use of the same transaction slice function that the transactions/:id endpoint makes use of to efficently caluclate a running total
    transaction_slice = AccountTransactionGenerators.generate_transaction_slice(seed, count, account_id, running_balance)
    running_balance = transaction_slice.running_balance

    # after 90 days worth of transactions, return the balance
    if count <= 0 do
      running_balance
    else
      generate_running_balance(seed, account_id, count, running_balance)
    end
  end

  # generates and fills in the balance template with relevant data for a specific account
  def generate_balance_details(account_id, seed) do
    available = generate_running_balance(seed, account_id)

    base_url = ApiSandboxChallengeWeb.Endpoint.url()
    # I'd liked to have procedurally generated the ledger as well. So much to do, so little time
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
