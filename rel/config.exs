# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
Path.join(["rel", "plugins", "*.exs"])
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :rna_umbrella,
    # This sets the default environment used by `mix release`
    default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"Yv)S.IV0L,=H,{OTraQP~akt6E@s}y|1*Ge^unQ@[62nEV,0?q3la|2WmjhC9dT("
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"|,$V}URd*AV6x^d`gD%.N*0qZ7Fp/$wThK16*`w*6G.cac&(t?4Qs0.QKi2c|VD8"
  set vm_args: "rel/vm.args"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :rna_umbrella do
  set version: "0.3.0"
  # set output_dir: './releases/rna_umbrella'
  set applications: [
    rna_web: :permanent,
    rna: :permanent,
    crontab: :permanent,
    net_snmp_ex: :permanent,
    bus: :permanent]
end

release :rna do
  set version: current_version(:rna)
  # set output_dir: "_build/prod/rel/rna_umbrella"
  set applications: [
    :runtime_tools,
    rna: :permanent,
    bus: :permanent,
    crontab: :permanent,
    net_snmp_ex: :permanent]
end

release :rna_web do
  set version: current_version(:rna_web)
  # set output_dir: "_build/prod/rel/rna_umbrella"
  set applications: [
    :runtime_tools,
    rna_web: :permanent
  ]
end
