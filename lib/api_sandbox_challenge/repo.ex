defmodule ApiSandboxChallenge.Repo do
  use Ecto.Repo,
    otp_app: :api_sandbox_challenge,
    adapter: Ecto.Adapters.Postgres
end
