class MqttGetJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    topic = args[0]

    mq = MqttClient.new
    message = mq.get_message(topic)
    message
  end
end
