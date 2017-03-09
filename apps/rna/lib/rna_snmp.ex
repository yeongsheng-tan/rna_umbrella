defmodule RnaSnmp do
  def get_switch_info(ip_addr) do
    credential = NetSNMP.credential :v2c, Application.get_env(:rna, :community_string)
    agent=URI.parse "snmp://#{ip_addr}"
    sysname_object=SNMPMIB.object ".1.3.6.1.2.1.1.1.0", :string, ""
    [ok: snmp_obj] = sysname_object |> NetSNMP.get(agent, credential)
    snmp_obj
  end
end
