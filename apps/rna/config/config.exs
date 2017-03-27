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
      args: ["172.30.65.149"]
    ]
  ]
]

config :bus,
  host: 'localhost',
 	port: 1883,
 	client_id: "Rna.SNMP_Poller", #needs to be string.
  keep_alive: 30, #this is in seconds.
 	auto_reconnect: true, #if client get disconnected, it will auto reconnect.
  auto_connect: true, #this will make sure when you start :bus process, it gets connected autometically
  callback: Rna.MqttClient #callback module, you need to implement callback inside.

import_config "#{Mix.env}.exs"
