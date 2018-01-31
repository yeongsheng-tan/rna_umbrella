defmodule Rna.Mixfile do
  use Mix.Project

  def project do
    [app: :rna,
     version: "0.3.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.6",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Rna.Application, []},
     extra_applications: [:logger, :runtime_tools, :quantum, :bus]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:net_snmp_ex, git: "https://github.com/jonnystorm/net-snmp-elixir.git", app: false},
     {:protox, "~> 0.16"},
     {:quantum, "~> 2.2"},
     {:bus, "~> 0.1.4"},
     {:ex_doc, "~> 0.18", only: :dev}
    ]
  end

  defp aliases do
    []
  end
end
