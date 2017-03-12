defmodule Rna.Snmp do
  def get_switch_info(ip_addr) do
    # IO.inspect Application.get_env(:rna, :community_string)
    credential = NetSNMP.credential :v2c, Application.get_env(:rna, :community_string)
    agent=URI.parse "snmp://#{ip_addr}"
    sysname_object=SNMPMIB.object ".1.3.6.1.2.1.1.1.0", :string, ""
    [ok: snmp_obj] = sysname_object |> NetSNMP.get(agent, credential)
    IO.inspect snmp_obj
    snmp_obj
  end

  def gpb_encode_switch_info(ip_addr) do
    %SNMPMIB.Object{oid: _oid, type: type, value: val}= get_switch_info(ip_addr)
    Rna.Protobufs.SwitchInfo.new(value: val, type: type) |> Rna.Protobufs.SwitchInfo.encode
  end
end
