use Mix.Config

# Configure your database
config :rna, Rna.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "rna_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
