use Mix.Config

config :quantum,
  global?: true,
  timezone: "Asia/Singapore"

config :rna,
  ecto_repos: [Rna.Repo],
  community_string: "public"

config :quantum, rna: [
  cron: [
    publish_switch_info: [
      # Every 1 minutes
      schedule: "*/1 * * * *",
      task: {Rna.Snmp, :publish_switch_info},
      args: ["demo.snmplabs.com"]
    ]
  ]
]

import_config "#{Mix.env}.exs"
