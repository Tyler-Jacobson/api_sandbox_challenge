defmodule ApiSandboxChallenge.DataGenerators.AccountTransactionGenerators do

  alias ApiSandboxChallenge.DataGenerators.GlobalGenerators
  alias ApiSandboxChallenge.DataGenerators.AccountGenerators

  # generates the transaction_id for use throughout the application
  def generate_transaction_id(seed, transaction_index, account_index) do
    transaction_id_generated_values = GlobalGenerators.generate_values(seed, 20, account_index, 36, 20, &GlobalGenerators.int_list_to_alphanumeric_string/1, transaction_index)
    _transaction_id = "txn_#{transaction_id_generated_values.return_value}"
  end

  # finds the list index of a transaction by its id. Useful for generating data specific to each transaction
  def find_transaction_index_by_id(account_index, transaction_id, seed, count \\ 90) do
    count = count - 1

    # generates a transaction id to check against
    found_id = generate_transaction_id(seed, count, account_index)

    cond do
      found_id == transaction_id -> count
      count <= 0 -> "No transaction with id #{transaction_id} found"
      true -> find_transaction_index_by_id(account_index, transaction_id, seed, count)
    end
  end

  # randomly selects a merchant. Some of the categories might be a bit off
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

  # generates an individual transaction based on several parameters
  def generate_transaction(seed, transaction_index, account_id, running_balance) do

    # finds the index of the account tied to the transaction. Using this during generation ensures that each account has a different set of transactions
    account_index = AccountGenerators.find_account_index_by_id(seed, account_id, GlobalGenerators.total_accounts(seed))

    # generates the id for the transaction
    transaction_id = generate_transaction_id(seed, transaction_index, account_index)

    # generates the actual amount of money billed for the transaction. Given more time I would have liked to use a dedicated money module for this,
    # as it would be far superior to the imprecise calcuations obtained when using doubles
    amount_generated_values = GlobalGenerators.generate_values(seed, 20, account_index, 9, 4, &GlobalGenerators.generated_values_to_float/1, transaction_index)

    # extracts the billed amount float and truncates it for display
    amount = amount_generated_values.return_value
    running_balance = String.to_float(running_balance) - amount
    running_balance = running_balance |> Float.ceil(2)

    # selects a merchant for the transaction
    selected_merchant = GlobalGenerators.generate_values(seed, amount_generated_values.index, transaction_index, 79, 1, &select_merchant/1, transaction_index)

    # since the transaction_index starts at 90, and is counted down as transactions are prepended to the full list each "day",
    # it's very easy to find the correct date by simply multiplying the -number of seconds in a day by the transaction_index
    date = DateTime.add(DateTime.utc_now(), -86400 * transaction_index, :second)

    # application base url, should work in the case of deployment
    base_url = ApiSandboxChallengeWeb.Endpoint.url()

    # the template for the transaction is filled in and returned
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

  # runs recursively to call the above function until the 90 transactions are generated
  # keeps track of the running balance in between transactions
  def generate_transactions(seed, account_id, count \\ 90, running_balance \\ "10000.0", transactions_list \\ []) do
    count = count - 1

    # generates an individual transaction and adds it to the transactions list
    transaction = generate_transaction(seed, count, account_id, running_balance)
    transactions_list = [transaction | transactions_list]

    # updates the running balance
    running_balance = transaction.running_balance

    # after generating 90 transactions, return the transactions_list
    if count <= 0 do
      transactions_list
    else
      generate_transactions(seed, account_id, count, running_balance, transactions_list)
    end
  end

  # generates a transaction slice. This is used when calculating running totals outside of the /transactions endpoint
  # the goal is, of course, to speed up response times and avoid wasting resources on unnecessary calculations
  def generate_transaction_slice(seed, transaction_index, account_id, running_balance) do

    # finds the index for the account which the transaction belongs to, this is needed when generating the id for a specific transaction
    account_index = AccountGenerators.find_account_index_by_id(seed, account_id, GlobalGenerators.total_accounts(seed))

    # generates the id for the transaction
    transaction_id = generate_transaction_id(seed, transaction_index, account_index)

    # generates the actual amount of money billed for the transaction
    amount_generated_values = GlobalGenerators.generate_values(seed, 20, account_index, 9, 4, &GlobalGenerators.generated_values_to_float/1, transaction_index)

    # extracts the billed amount float and truncates it for display
    amount = amount_generated_values.return_value
    running_balance = String.to_float(running_balance) - amount
    running_balance = running_balance |> Float.ceil(2)

    # returns the transaction_id, running_balance, and the billed amount.
    # This is all the information needed when processing running totals, without the need to return full transaction details
    %{
      transaction_id: transaction_id,
      running_balance: "#{running_balance}",
      amount: amount
    }
  end

  # used in conjunction with generate_transaction_slice to efficiently calculate running totals for a transaction with a specific id
  def generate_running_balance_by_transaction_id(seed, desired_transaction_id, account_id, count \\ 90, running_balance \\ "10000.0") do
    count = count - 1

    # generates a single transaction slice
    transaction_slice = generate_transaction_slice(seed, count, account_id, running_balance)

    # tracks the running_balance as each transaction slice is checked against the desired id
    running_balance = transaction_slice.running_balance

    # if the desired id is found, return the most recent transaction slice's running balance
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
    # finds the running balance for the specific id requested using the functions above
    running_balance = generate_running_balance_by_transaction_id(seed, transaction_id, account_id)
    # finds the index of the user account associated with the transaction, the index will be used for further procedural generation
    account_index = AccountGenerators.find_account_index_by_id(seed, account_id, GlobalGenerators.total_accounts(seed))
    # the transaction index can now be found. With this final piece, a full transaction can be generated
    transaction_index = find_transaction_index_by_id(account_index, transaction_id, seed)

    # transaction with the requested id and details is returned
    generate_transaction(seed, transaction_index, account_id, running_balance)
  end
end
