defmodule Rna.MqttClient do
  def on_message_received(topic, payload) do
    IO.inspect "on_message_received: Topic -> #{topic} |\n #{payload}"
  end

  def on_error(err) do
    IO.inspect "on_error: Error -> #{err}"
  end

  def on_disconnect(msg) do
    IO.inspect "on_disconnect: Disconnect -> #{msg}"
  end

  def on_connect(msg) do
    IO.inspect "on_connect: Connect -> #{msg}"
  end

  def on_info(msg) do
    IO.inspect "on_info: Info -> #{msg}"
  end

  def publish(msg) do
    topic = "sci-topic"
    qos = 0
    IO.inspect Rna.GPBUtils.decode(msg)
    callback_fun = fn(msg) -> IO.inspect "IN Bus.Mqtt.publish callback_fun #{msg}" end
    Bus.Mqtt.publish(topic, msg, callback_fun, qos)
  end
end
