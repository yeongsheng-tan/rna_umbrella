use Mix.Config

config :quantum,
  global?: true,
  timezone: "Asia/Singapore"

config :rna,
  ecto_repos: [Rna.Repo],
  community_string: "hei1Eeto"

config :quantum, rna: [
  cron: [
    publish_switch_info: [
      # Every 1 minutes
      schedule: "*/1 * * * *",
      task: {Rna.Snmp, :gpb_encode_switch_info},
      args: ["172.30.65.149"]
    ]
  ]
]

import_config "#{Mix.env}.exs"
