defmodule Rna.Snmp do
  @moduledoc ~S"""
  Provides the abstractions to SNMP interfaces
  Also does GPB message encoding (this should be factored to another Module)
  """

  def get_switch_info(ip_addr) do
    agent = URI.parse "snmp://#{ip_addr}"
    credential = get_snmp_credential()
    sysname_object = SNMPMIB.object ".1.3.6.1.2.1.1.1.0", :string, ""
    [ok: snmp_obj] = sysname_object |> NetSNMP.get(agent, credential)
    # IO.inspect snmp_obj
    snmp_obj
  end

  def gpb_encode_switch_info(ip_addr) do
    %SNMPMIB.Object{oid: _oid, type: type, value: val} = get_switch_info(ip_addr)
    Rna.Protobufs.SwitchInfo.new(value: val, type: type) |> Rna.Protobufs.SwitchInfo.encode
  end

  defp get_snmp_credential do
    [community_string: snmp_cred] = :ets.lookup(:snmp_cred_store, :community_string)
    case snmp_cred do
      nil -> setup_snmp_cred()
      _ -> snmp_cred
    end
  end

  defp setup_snmp_cred do
    # IO.inspect Application.get_env(:rna, :community_string)
    credential = NetSNMP.credential :v2c, Application.get_env(:rna, :community_string)
    :ets.insert_new(:snmp_cred_store, {:community_string, credential})
    credential
  end
end
