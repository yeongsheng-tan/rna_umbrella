use Mix.Config

config :rna, ecto_repos: [Rna.Repo], community_string: "hei1Eeto"

import_config "#{Mix.env}.exs"
