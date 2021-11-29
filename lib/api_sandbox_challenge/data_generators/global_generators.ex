defmodule ApiSandboxChallenge.DataGenerators.GlobalGenerators do

  # the powerhouse of the entire app's procedural generation ability. Accepts a wide range of arguments in order to ensure that each generated sequence is unique
  def generate_values(seed, local_index, account_index, number_of_possible_outcomes, count_needed, processing_function, transaction_index \\ 0, return_list \\ []) do
    # incoming seed base values are multiplied by one in a range of possible prime numbers to increase procedural variance
    rotating_primes = [53, 73, 89, 101, 109, 139, 151, 227, 47, 113, 149, 157, 163, 5, 23, 29, 79, 257, 197, 181, 191, 89, 97, 43, 37, 61, 211]

    # the generation works by incrementing through the values provided by the seed. The seed_index is the current increment.
    # IE: for seed 973265621, a seed_index of [2] will mean that the "3" from the seed is used as part of the base for procedural generation
    seed_index = rem(local_index, 9)
    prime_index = rem(local_index, Enum.count(rotating_primes))

    # additional base variance is needed when generating for the /transactions route, in order to prevent duplicate entries
    prime_index_transaction = rem(transaction_index, Enum.count(rotating_primes))
    transaction_index = transaction_index + prime_index_transaction

    # gets the integer of the seed(converted to a list) at a specific index, adds it to the index, along with several other values, in order to generate the value for a single digit
    base_value = (Enum.at(Integer.digits(seed), seed_index) + local_index + (account_index * 13) + (transaction_index * 7)) * Enum.at(rotating_primes, prime_index)

    # the remainder of the above value is taken to create final procedural outputs from the seed
    return_value = rem(base_value, number_of_possible_outcomes)

    # the index is incremented before being passed to the function again recursively, the effect is similar to that of a list index being incremented,
    # but this value can be returned with the return_list, and then passed in the next time this function is run (non-recursively) to ensure that
    # each new run of the function does not produce the same output
    local_index = local_index + 1

    # new value is prepended to the list, I've read that in Elixir prepending is more resource efficient
    return_list = [return_value | return_list]

    # base case to exit recursion. If the number of generated values is equal or greater than the number needed
    if Enum.count(return_list) >= count_needed do
      # a processing function (detailed below) is run, which has been passed as an argument, and will convert the current list of integers to its desired final output
      return_value = processing_function.(return_list)
      %{return_value: return_value, index: local_index}
    else
      # runs recursively until the number of needed digits is met
      generate_values(seed, local_index, account_index, number_of_possible_outcomes, count_needed, processing_function, transaction_index, return_list)
    end
  end

  # converts a list containing the numbers 1-36 to a string containing a mix of numbers and letters - Passed as a processing function to generate_values()
  def int_list_to_alphanumeric_string(numbers_list, index \\ 0, return_string \\ "") do
    characters_list = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    number_index = Enum.at(numbers_list, index)
    character = Enum.at(characters_list, number_index)

    return_string = return_string <> character

    index = index + 1
    if index >= Enum.count(numbers_list) do
      return_string
    else
      int_list_to_alphanumeric_string(numbers_list, index, return_string)
    end
  end

  # converts list to string. [8, 5, 2, 6] to "8526" - Passed as a processing function to generate_values()
  def list_to_string(numbers_list, index \\ 0, string \\ "") do
    character = Enum.at(numbers_list, index)

    string = string <> "#{character}"

    index = index + 1
    if index >= Enum.count(numbers_list) do
      string
    else
      list_to_string(numbers_list, index, string)
    end
  end

  # converts list to float. [8, 5, 2, 6] to 85.26 -  Passed as a processing function to generate_values()
  def generated_values_to_float(index_list) do
    string_nums = list_to_string(index_list)
    float_side_one = String.slice(string_nums, 0..-3)
    float_side_two = String.slice(string_nums, 2..-1)
    float_string = "#{float_side_one}.#{float_side_two}"
    _float_string = String.to_float(float_string)
  end

  # Determines the total number of accounts to be generated. 1-4 based on the seed
  def total_accounts(seed) do
    rem((seed + 3), 5)
  end
end
