# MQTT client class
class MqttClient
  def initialize
    # uri=URI.parse("mqtt://mqttuser:changeme@localhost:1883")
    uri = URI.parse(ENV['MQTT_URL'])
    @client = MQTT::Client.connect(host: uri.hostname,
                                   port: uri.port,
                                   username: uri.user,
                                   password: uri.password)
  end

  def send_message(topic, message)
    @client.publish(topic, message)
    # self.disconnect()
  end

  def get_message(topic)
    _topic, message = @client.get(topic)
    message
  end
end
