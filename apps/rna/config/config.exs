use Mix.Config

config :rna, ecto_repos: [Rna.Repo]

import_config "#{Mix.env}.exs"
