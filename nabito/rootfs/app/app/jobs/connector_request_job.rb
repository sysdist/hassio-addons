# send MQTT message - args: topic, message
class ConnectorRequestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    topic = args[0]
    message = args[1]
    mq = MqttClient.new
    mq.send_message(topic, message)
  end
end
