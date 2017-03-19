defmodule Rna.Protobufs do
  @moduledoc ~S"""
  Provides the Protocol Buffers' .proto message definitions to
  message payload attribute compile/macro-expansion
  for use in corresponding MFA
  """
  use Protobuf, from: Path.expand("../../proto/switch_info.proto", __DIR__)
end
