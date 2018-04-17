use Mix.Config

config :local_ledger_db, LocalLedgerDB.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "LOCAL_LEDGER_DATABASE_URL", "postgres://localhost/local_ledger_prod"}

config :cloak, Salty.SecretBox.Cloak,
  tag: "SBX",
  default: true,
  keys: [
    %{
      tag: <<1>>,
      key: {:system, "LOCAL_LEDGER_SECRET_KEY"},
      default: true
    }
  ]
