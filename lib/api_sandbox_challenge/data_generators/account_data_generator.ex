defmodule ApiSandboxChallenge.DataGenerators.AccountDataGenerator do
  # return all account data for a given seed
  def all_accounts do
    [
      %ApiSandboxChallenge.Management.Account{
        currency: "USD",
        enrollment_id: "enr_nmf3f7758gpc7b5cd6000",
        id: "acc_nmfff743stmo5n80t4000",
        institution: %{
          institution_id: "citibank",
          name: "Citibank"
        },
        last_four: "3836",
        links: %{
          balances: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/balances",
          details: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/details",
          self: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
          transactions: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/transactions"
        },
        name: "My Checking",
        subtype: "checking",
        type: "depository"
      },
      %ApiSandboxChallenge.Management.Account{
        currency: "USD",
        enrollment_id: "enr_nmftg43ewubftwy7z2000",
        id: "acc_nmfrhsafs84fhzwz7000",
        institution: %{
          institution_id: "citibank",
          name: "Citibank"
        },
        last_four: "3836",
        links: %{
          balances: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/balances",
          details: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/details",
          self: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
          transactions: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/transactions"
        },
        name: "Timmy's Checking",
        subtype: "checking",
        type: "depository"
      },
      %ApiSandboxChallenge.Management.Account{
        currency: "USD",
        enrollment_id: "enr_nmfuf7ews34fdsfz1000",
        id: "acc_nmfuksefybsujey3000",
        institution: %{
          institution_id: "citibank",
          name: "Citibank"
        },
        last_four: "3836",
        links: %{
          balances: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/balances",
          details: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/details",
          self: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
          transactions: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/transactions"
        },
        name: "Jimmy Carter",
        subtype: "checking",
        type: "depository"
      }
    ]
  end

  def get_account(id) do
    %ApiSandboxChallenge.Management.Account{
      currency: "USD",
      enrollment_id: "enr_nmfuf7ews34fdsfz1000",
      id: "acc_nmfuksefybsujey3000",
      institution: %{
        institution_id: "citibank",
        name: "Citibank"
      },
      last_four: "3836",
      links: %{
        balances: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/balances",
        details: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/details",
        self: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
        transactions: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/transactions"
      },
      name: "Timmy",
      subtype: "checking",
      type: "depository"
    }
  end

  def get_account_details(id) do
    %ApiSandboxChallenge.Management.AccountDetail{
      account_id: "acc_nmfff743stmo5n80t4000",
      account_number: "891824333836",
      links: %{
        account: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
        self: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/details"
      },
      routing_numbers: %{
        ach: "581559698"
      }
    }
  end

  def get_balance_details(id) do
    %ApiSandboxChallenge.Management.Balance{
      account_id: "acc_nmfff743stmo5n80t4000",
      available: "33648.09",
      ledger: "33803.48",
      links: %{
        account: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
        self: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/balances"
      }
    }
  end

  def all_transactions(id) do
    [
      %ApiSandboxChallenge.Management.Transaction{
        account_id: "acc_nmfff743stmo5n80t4000",
        amount: "90.54",
        date: "2021-08-12",
        description: "In-N-Out Burger",
        details: %{
          category: "dining",
          counterparty: %{
            name: "IN N OUT BURGER",
            type: "organization"
          },
          processing_status: "complete"
        },
        transaction_id: "txn_nmfo2gtnstmo5n80t4004",
        links: %{
          account: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
          self:
            "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/transactions/txn_nmfo2gtnstmo5n80t4004"
        },
        running_balance: "33648.09",
        status: "posted",
        type: "ach"
      },
      %ApiSandboxChallenge.Management.Transaction{
        account_id: "acc_nmfff743stmo5n80t4000",
        amount: "50.50",
        date: "2021-08-11",
        description: "Uber",
        details: %{
          category: "dining",
          counterparty: %{
            name: "Uber",
            type: "organization"
          },
          processing_status: "complete"
        },
        transaction_id: "txn_nmfo2gtnstmo5n80t4004",
        links: %{
          account: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
          self:
            "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/transactions/txn_nmfo2gtnstmo5n80t4004"
        },
        running_balance: "33648.09",
        status: "posted",
        type: "ach"
      }
    ]
  end

  def get_transaction(id, transaction_id) do
    %ApiSandboxChallenge.Management.Transaction{
      account_id: "acc_nmfff743stmo5n80t4000",
      amount: "50.50",
      date: "2021-08-11",
      description: "Uber",
      details: %{
        category: "dining",
        counterparty: %{
          name: "Uber",
          type: "organization"
        },
        processing_status: "complete"
      },
      transaction_id: "txn_nmfo2gtnstmo5n80t4004",
      links: %{
        account: "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000",
        self:
          "https://api.teller.io/accounts/acc_nmfff743stmo5n80t4000/transactions/txn_nmfo2gtnstmo5n80t4004"
      },
      running_balance: "33648.09",
      status: "posted",
      type: "ach"
    }
  end

end
