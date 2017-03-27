defmodule Rna.Snmp do
  @moduledoc ~S"""
  Provides the abstractions to SNMP interfaces
  Also does GPB message encoding (this should be factored to another Module)
  """

  def publish_switch_info(ip_addr) do
    # %SNMPMIB.Object{oid: _oid, type: type, value: val} = get_switch_info(ip_addr)
    # gpb_switch_info = SwitchInfo.new(value: val, type: type, encoded: :true, date: 2147483647, unit_price: 72.5011)
    ip_addr
    |> get_switch_info
    |> Rna.GPBUtils.encode
    |> Rna.MqttClient.publish
  end

  def get_switch_info(ip_addr) do
    agent = URI.parse "snmp://#{ip_addr}"
    credential = get_snmp_credential(ip_addr)
    sysname_object = SNMPMIB.object ".1.3.6.1.2.1.1.1.0", :string, ""
    [ok: snmp_obj] = sysname_object |> NetSNMP.get(agent, credential)
    snmp_obj
  end

  defp get_snmp_credential(ip_addr) do
    case :ets.lookup(:snmp_cred_store, ip_addr) do
      [] -> setup_snmp_cred(ip_addr)
      [{_ip_addr, snmp_cred}] -> snmp_cred
    end
  end

  defp setup_snmp_cred(ip_addr) do
    # IO.inspect Application.get_env(:rna, :community_string)
    credential = NetSNMP.credential :v2c, Application.get_env(:rna, :community_string)
    :ets.insert_new(:snmp_cred_store, {ip_addr, credential})
    credential
  end
end
