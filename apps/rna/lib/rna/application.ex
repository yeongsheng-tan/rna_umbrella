defmodule Rna.Application do
  @moduledoc """
  The Rna Application Service.

  The rna system business domain lives in this application.

  Exposes API to clients such as the `Rna.Web` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Pre-create a protected cache named table for snmp credentials (set)
    :ets.new(:snmp_cred_store, [:ordered_set, :public, :named_table, read_concurrency: true])

    Supervisor.start_link([
      # worker(Rna.Repo, []),
    ], strategy: :one_for_one, name: Rna.Supervisor)

  end
end
