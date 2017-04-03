# rna_umbrella
A simple ICX SNMP query/response over REST API with Phoenix/Elixir PoC

### Up & running on OSX macOS
1. Install OSX net-snmp binaries `brew install net-snmp`
1. Install elixir `brew install elixir` (current project state is running with elixir 1.4.2)
1. Install phoenix 1.3-rc-1 `mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez` (see https://elixirforum.com/t/phoenix-v1-3-0-rc-0-released/3947 and https://github.com/phoenixframework/phoenix/blob/master/CHANGELOG.md)
1. Update local hex packages index `mix local.hex`
1. From root of this project install dependencies `mix deps.get`
1. Startup phoenix umbrella app `mix phx.server` (i.e. rna_web and rna)
1. Ensure you are in LAN (VPN or office) that can reach 172.30.65.x network
1. From browser, hit URL http://localhost:4000/api/v1/switches/:interested_switch_ip_address


### Build and run using docker-compose
1. `docker-compose stop && docker-compose rm -v && docker-compose up -d icx_manager`
1. Refer to :project_src_root_dir/docker-compose.yml and :project_src_root_dir/docker/Dockerfile.build for the details

### Build and run using hex package mix_docker workflow
1. `mix docker.build`
1. `mix docker.release`
1. `docker run -e PORT=9066 -p 1883:1883 -p 8000:9066 \-it --rm icx/icx_manager:release foreground`
1. NOTE: Currently the above will immediately crash the container on startup; Reason being, The Mqtt.Bus app is unable to connect to a non-existant mosquitto broker, which the single purpose 'foreground' command will not start
