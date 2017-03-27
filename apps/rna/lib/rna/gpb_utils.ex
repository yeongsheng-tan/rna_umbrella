defmodule Rna.GPBUtils do
  def encode(%SNMPMIB.Object{oid: _oid, type: type, value: val}) do
    # message = SwitchInfo.encode(gpb_switch_info)
    now = DateTime.utc_now() |> DateTime.to_unix()
    gpb_switch_info_encoded = %SwitchInfo{value: val, type: type, encoded: :true, date: now, unit_price: 7250.725012345}
    |> Protox.Encode.encode()
    |> :binary.list_to_bin()
    IO.puts "ENCODED:"
    IO.inspect gpb_switch_info_encoded
    IO.puts "is_binary: #{is_binary(gpb_switch_info_encoded)} | is_bitstring: #{is_bitstring(gpb_switch_info_encoded)}"
    gpb_switch_info_encoded
  end

  def decode(encoded_payload) do
    case SwitchInfo.decode(encoded_payload) do
      {:ok, %SwitchInfo{value: v, type: t, encoded: e, date: d, unit_price: u}} -> IO.puts "DECODED:\n value: #{v}\ntype: #{t}\nencoded: #{e}\ndate: #{d}\nunit_price: #{u}"
      _ -> IO.puts "ERROR Decoding GPB payload!!!"
    end
  end
end
