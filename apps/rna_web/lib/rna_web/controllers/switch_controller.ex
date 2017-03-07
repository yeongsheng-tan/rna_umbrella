defmodule Rna.Web.SwitchController do
  use Rna.Web, :controller

  def index(conn, _params) do
    # switches = []
    credential = NetSNMP.credential :v2c, "public"
    agent=URI.parse "snmp://10.0.1.20"
    sysname_object=SNMPMIB.object ".1.3.6.1.2.1.1.5", :string, ""
    [ok: snmp_obj] = sysname_object |> SNMPMIB.index(0) |> NetSNMP.get(agent, credential)
    switches = Poison.encode!(snmp_obj)
    json conn, switches
  end
end
