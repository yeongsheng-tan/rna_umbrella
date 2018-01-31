use Mix.Config

config :bus,
  host: 'mosquitto_broker1',
 	port: 1883,
 	client_id: "Rna.SNMP_Poller", #needs to be string.
  keep_alive: 30, #this is in seconds.
  auto_reconnect: true, #if client get disconnected, it will auto reconnect.
  auto_connect: true, #this will make sure when you start :bus process, it gets connected autometically
  callback: Rna.MqttClient #callback module, you need to implement callback inside.

import_config "prod.secret.exs"
