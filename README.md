# rna_umbrella
A simple ICX SNMP query/response over REST API with Phoenix/Elixir PoC

### Up & running on OSX macOS
1. Install OSX net-snmp binaries `brew install net-snmp`
2. Install elixir `brew install elixir` (current project state is running with elixir 1.6.1)
3. Install phoenix 1.3.0
4. Update local hex packages index `mix local.hex`
5. From root of this project install dependencies `mix deps.get`
6. Startup phoenix umbrella app `mix phx.server` (i.e. rna_web and rna)
7. From browser, hit URL http://localhost:4000/api/v1/switches/:interested_switch_ip_address

### Workflow #1: Docker build, docker release docker-compose workflow using alpine docker images (single-purposed containers)
1. `docker build -f Dockerfile.build.rna_umbrella -t elixirsg_alp/rna_umbrella:build .`
2. `docker create --name rna_umb_tmp elixirsg_alp/rna_umbrella:build`
3. `docker cp rna_umb_tmp:/opt/app/_build/prod/rel/rna_umbrella/releases/0.3.0/rna_umbrella.tar.gz .`
4. `docker rm -f rna_umb_tmp`
5. `docker build -f Dockerfile.release.rna_umbrella -t elixirsg_alp/rna_umbrella:release .`
6. `docker-compose up -d`
7. See your web app up and running at http://<your_docker_engine_host_ip>:8000 (e.g. http://172.30.64.135:8000 - the typical phoenix webapp landing page)
8. Test the REST API endpoint using your browser http://<your_docker_engine_host_ip>:8000/api/v1/switches/demo.snmplabs.com
  1. You should see a response similar to the below on your browser:
  ```
  "{\"value\":\"Linux zeus 4.8.6.5-smp #2 SMP Sun Nov 13 14:58:11 CDT 2016 i686\",\"type\":4,\"oid\":[1,3,6,1,2,1,1,1,0]}"
  ```
10. Test your REST API endpoint using `curl`:
  1. `curl --header "Accept:application/json" http://172.30.64.135:8000/api/v1/switches/demo.snmplabs.com`
  2. Response expected:
  ```
  "{\"value\":\"Linux zeus 4.8.6.5-smp #2 SMP Sun Nov 13 14:58:11 CDT 2016 i686\",\"type\":4,\"oid\":[1,3,6,1,2,1,1,1,0]}"
  ```
11. Install a local mosquitto_client (e.g. `brew install mosquitto`)
12. Startup a local mosquitto client subscriber to receive published GPB payload over mqtt from your app container:
  1. `mosquitto_sub -h <your_docker_engine_host_ip> -p 3883 -t "#"` (assuming you are testing this over a connected machine in same network as the docker-engine host)
  2. You should see something similar to the below every 1 minute interval:
  ```
  ?Linux zeus 4.8.6.5-smp #2 SMP Sun Nov 13 14:58:11 CDT 2016 i686
                                                                 -͕
  ?Linux zeus 4.8.6.5-smp #2 SMP Sun Nov 13 14:58:11 CDT 2016 i686 ġ
                                                                    -͕

  ?Linux zeus 4.8.6.5-smp #2 SMP Sun Nov 13 14:58:11 CDT 2016 i686 š
                                                                    -͕

  ?Linux zeus 4.8.6.5-smp #2 SMP Sun Nov 13 14:58:11 CDT 2016 i686 ơ
                                                                    -͕
  ```

### Workflow #2: Build and run using docker-compose (using All-in-One with debian base docker images)
1. `docker-compose stop && docker-compose rm -v && docker-compose up -d icx_manager`
2. Refer to :project_src_root_dir/docker-compose.yml and :project_src_root_dir/docker/Dockerfile.build for the details

### Workflow #2: Build and run using hex package mix_docker workflow
1. Install macOS docker-machine
  1. `brew install docker-machine`
2. Spin up a RancherOS HostVM
  1. `docker-machine create -d virtualbox --virtualbox-boot2docker-url https://releases.rancher.com/os/latest/rancheros.iso rna-umbrella-hostvm`
3. List set of VM candidates that can run and manage docker containers
  1. `docker-machine ls`
4. Inspect docker-env exposed by docker-machine for the above VM spun up
  1. `docker-machine env rna-umbrella-hostvm`
5. Set target VM as DOCKER_HOST to send/receive docker commands (i.e. act as docker daemon/engine)
  1. `eval $(docker-machine env rna-umbrella-hostvm)`
6. Build rna_umbrella project in target compile and packaging docker container env and materialise as 'build' container image with ERTS pre-bundled
  1. `mix docker.build`
7. Build target runtime docker container env and unpack packaged application into the runtime 'release' container image and define necessary ENTRY_POINT command on container run
  1. `mix docker.release`
8. Startup and run the release container image
  1. `docker run -d --name icx_manager_aio -e PORT=9000 -p 3883:1883 -p 8000:9000 -it --rm icx/icx_manager:release`
9. Connect to above running instance of container via a remote console iex shell
  1. `docker exec -it icx_manager_aio /opt/app/bin/rna_umbrella remote_console`
10. Test run a known public API
  1. Using the above remote console iex shell:
    1. `Rna.Snmp.get_switch_info("demo.snmplabs.com")`
