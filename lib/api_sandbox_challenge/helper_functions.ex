defmodule ApiSandboxChallenge.HelperFunctions do

  # parses the incoming test_token_000000000 for it's seed value of 000000000
  def parse_token(token) do
    split_token = String.split(token, "_")
    seed = Enum.at(split_token, 2)
    String.to_integer(seed)
  end
end
