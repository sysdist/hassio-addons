class MqttSendJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    topic = args[0]
    message = args[1]
    mq = MqttClient.new
    mq.send_message(topic, message)
  end
end
