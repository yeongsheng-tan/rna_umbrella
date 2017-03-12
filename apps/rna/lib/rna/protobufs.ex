defmodule Protobufs do
  use Protobuf, from: Path.expand("../../proto/switch_info.proto", __DIR__)
end
