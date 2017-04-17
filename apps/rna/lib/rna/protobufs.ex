defmodule Rna.Protobufs do
  @moduledoc ~S"""
  Provides the Protocol Buffers' .proto message definitions to
  message payload attribute compile/macro-expansion
  for use in corresponding MFA
  """
  @external_resource "./proto/switch_info.proto"
  use Protox, files: [ "./proto/switch_info.proto"]
end
