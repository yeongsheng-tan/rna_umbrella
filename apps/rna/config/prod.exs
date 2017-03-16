use Mix.Config

# Configure your database
config :rna, Rna.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "rna_dev",
  hostname: "localhost",
  pool_size: 10
