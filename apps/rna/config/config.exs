use Mix.Config

config :rna, ecto_repos: [Rna.Repo], community_string: "public"

import_config "#{Mix.env}.exs"
