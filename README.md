# rna_umbrella
A simple ICX SNMP query/response over REST API with Phoenix/Elixir PoC

### Up & running on OSX macOS
1. Install OSX net-snmp binaries `brew install net-snmp`
1. Install elixir `brew install elixir` (current project state is running with elixir 1.4.2)
1. Install phoenix 1.3-rc0 `mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez` (see https://elixirforum.com/t/phoenix-v1-3-0-rc-0-released/3947)
1. Update local hex packages index `mix local.hex`
1. From root of this project install dependencies `mix deps.get`
1. Startup phoenix umbrella app `mix phx.server` (i.e. rna_web and rna)
1. Ensure you are in LAN (VPN or office) that can reach 172.30.65.x network
1. From browser, hit URL http://localhost:4000/api/v1/switches/:interested_switch_ip_address
