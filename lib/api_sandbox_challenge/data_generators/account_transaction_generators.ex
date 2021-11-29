defmodule ApiSandboxChallenge.DataGenerators.AccountTransactionGenerators do

  alias ApiSandboxChallenge.DataGenerators.GlobalGenerators
  alias ApiSandboxChallenge.DataGenerators.AccountGenerators

  def generate_transaction_id(seed, transaction_index, account_index) do
    transaction_id_generated_values = GlobalGenerators.generate_values(seed, 20, account_index, 36, 20, &GlobalGenerators.int_list_to_alphanumeric_string/1, transaction_index)
    _transaction_id = "txn_#{transaction_id_generated_values.return_value}"
  end

  def find_transaction_index_by_id(account_index, transaction_id, seed, count \\ 90) do
    count = count - 1

    found_id = generate_transaction_id(seed, count, account_index)

    cond do
      found_id == transaction_id -> count
      count <= 0 -> "No transaction with id #{transaction_id} found"
      true -> find_transaction_index_by_id(account_index, transaction_id, seed, count)
    end
  end

  def select_merchant(index_list) do
    merchants = [
      ["Uber", "transportation"],
      ["Uber Eats", "dining"],
      ["Lyft", "transportation"],
      ["Five Guys", "dining"],
      ["In-N-Out Burger", "dining"],
      ["Chick-Fil-A", "dining"],
      ["AMC Metreon", "entertainment"],
      ["Apple", "electronics"],
      ["Amazon", "shopping"],
      ["Walmart", "shopping"],
      ["Target", "shopping"],
      ["Hotel Tonight", "accommodation"],
      ["Misson Ceviche", "dining"],
      ["The Creamery", "dining"],
      ["Caltrain", "transportation"],
      ["Wingstop", "dining"],
      ["Slim Chickens", "dining"],
      ["CVS", "health"],
      ["Duane Reade", "health"],
      ["Walgreens", "shopping"],
      ["Rooster & Rice", "dining"],
      ["McDonald's", "dining"],
      ["Burger King", "dining"],
      ["KFC", "dining"],
      ["Popeye's", "dining"],
      ["Shake Shack", "dining"],
      ["Lowe's", "shopping"],
      ["The Home Depot", "shopping"],
      ["Costco", "shopping"],
      ["Kroger", "shopping"],
      ["iTunes", "software"],
      ["Spotify", "entertainment"],
      ["Best Buy", "electronics"],
      ["TJ Maxx", "clothing"],
      ["Aldi", "shopping"],
      ["Dollar General", "shopping"],
      ["Macy's", "clothing"],
      ["H.E. Butt", "groceries"],
      ["Dollar Tree", "shopping"],
      ["Verizon Wireless", "phone"],
      ["Sprint PCS", "phone"],
      ["T-Mobile", "phone"],
      ["Kohl's", "clothing"],
      ["Starbucks", "service"],
      ["7-Eleven", "fuel"],
      ["AT&T Wireless", "phone"],
      ["Rite Aid", "health"],
      ["Nordstrom", "clothing"],
      ["Ross", "clothing"],
      ["Gap", "clothing"],
      ["Bed, Bath & Beyond", "home"],
      ["J.C. Penney", "clothing"],
      ["Subway", "dining"],
      ["O'Reilly", "transport"],
      ["Wendy's", "dining"],
      ["Dunkin' Donuts", "dining"],
      ["Petsmart", "home"],
      ["Dick's Sporting Goods", "shopping"],
      ["Sears", "clothing"],
      ["Staples", "office"],
      ["Domino's Pizza", "dining"],
      ["Pizza Hut", "dining"],
      ["Papa John's", "dining"],
      ["IKEA", "home"],
      ["Office Depot", "office"],
      ["Foot Locker", "clothing"],
      ["Lids", "clothing"],
      ["GameStop", "entertainment"],
      ["Sephora", "shopping"],
      ["MAC", "shopping"],
      ["Panera", "dining"],
      ["Williams-Sonoma", "home"],
      ["Saks Fifth Avenue", "clothing"],
      ["Chipotle Mexican Grill", "dining"],
      ["Exxon Mobil", "fuel"],
      ["Neiman Marcus", "clothing"],
      ["Jack In The Box", "dining"],
      ["Sonic", "dining"],
      ["Shell", "fuel"]
    ]
    selected_index = Enum.at(index_list, 0)
    Enum.at(merchants, selected_index)
  end


  def generate_transaction(seed, transaction_index, account_id, running_balance) do

    account_index = AccountGenerators.find_account_index_by_id(seed, account_id, GlobalGenerators.total_accounts(seed))

    transaction_id = generate_transaction_id(seed, transaction_index, account_index)

    amount_generated_values = GlobalGenerators.generate_values(seed, 20, account_index, 9, 4, &GlobalGenerators.generated_values_to_float/1, transaction_index)

    amount = amount_generated_values.return_value
    running_balance = String.to_float(running_balance) - amount
    running_balance = running_balance |> Float.ceil(2)

    selected_merchant = GlobalGenerators.generate_values(seed, amount_generated_values.index, transaction_index, 79, 1, &select_merchant/1, transaction_index)

    date = DateTime.add(DateTime.utc_now(), -86400 * transaction_index, :second)

    base_url = ApiSandboxChallengeWeb.Endpoint.url()

    %ApiSandboxChallenge.Management.Transaction{
      account_id: account_id,
      amount: "#{amount}",
      date: "#{date}",
      description: "#{Enum.at(selected_merchant.return_value, 0)}",
      details: %{
        category: "#{Enum.at(selected_merchant.return_value, 1)}",
        counterparty: %{
          name: "#{Enum.at(selected_merchant.return_value, 0)}",
          type: "organization"
        },
        processing_status: "complete"
      },
      transaction_id: transaction_id,
      links: %{
        account: "#{base_url}/accounts/#{account_id}?username=test_token_#{seed}",
        self: "#{base_url}/accounts/#{account_id}/transactions/#{transaction_id}?username=test_token_#{seed}"
      },
      running_balance: "#{running_balance}",
      status: "posted",
      type: "ach"
    }
  end

  def generate_transactions(seed, account_id, count \\ 90, running_balance \\ "10000.0", transactions_list \\ []) do
    count = count - 1

    transaction = generate_transaction(seed, count, account_id, running_balance)
    transactions_list = [transaction | transactions_list]

    running_balance = transaction.running_balance

    if count <= 0 do
      transactions_list
    else
      generate_transactions(seed, account_id, count, running_balance, transactions_list)
    end
  end

  def generate_transaction_slice(seed, transaction_index, account_id, running_balance) do

    account_index = AccountGenerators.find_account_index_by_id(seed, account_id, GlobalGenerators.total_accounts(seed))

    transaction_id = generate_transaction_id(seed, transaction_index, account_index)

    amount_generated_values = GlobalGenerators.generate_values(seed, 20, account_index, 9, 4, &GlobalGenerators.generated_values_to_float/1, transaction_index)

    amount = amount_generated_values.return_value

    running_balance = String.to_float(running_balance) - amount
    running_balance = running_balance |> Float.ceil(2)

    %{
      transaction_id: transaction_id,
      running_balance: "#{running_balance}",
      amount: amount
    }
  end

  def generate_running_balance_by_transaction_id(seed, desired_transaction_id, account_id, count \\ 90, running_balance \\ "10000.0") do
    count = count - 1

    transaction_slice = generate_transaction_slice(seed, count, account_id, running_balance)

    running_balance = transaction_slice.running_balance

    if desired_transaction_id == transaction_slice.transaction_id do
      "#{String.to_float(running_balance) + transaction_slice.amount}"
    else
      generate_running_balance_by_transaction_id(seed, desired_transaction_id, account_id, count, running_balance)
    end
  end



  # return all transactions for a specific account
  def all_transactions(seed, account_id) do
    generate_transactions(seed, account_id)
  end

  # return a specific transaction for a specific account
  def get_transaction(seed, account_id, transaction_id) do
    running_balance = generate_running_balance_by_transaction_id(seed, transaction_id, account_id)
    account_index = AccountGenerators.find_account_index_by_id(seed, account_id, GlobalGenerators.total_accounts(seed))
    transaction_index = find_transaction_index_by_id(account_index, transaction_id, seed)

    generate_transaction(seed, transaction_index, account_id, running_balance)
  end
end
