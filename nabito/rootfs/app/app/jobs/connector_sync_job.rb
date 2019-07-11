class ConnectorSyncJob < ApplicationJob
  queue_as :default

  def perform(*args)
    connector = args[0]
    mq = MqttClient.new
    mqtt_state = mq.get_message(connector.json_attributes_topic)
    json_state = JSON.parse(mqtt_state)

    ts_now = Time.now.utc
    puts "UTC time now: " + ts_now.to_s
    puts "connector time: " + json_state["Time"] 
    last_ts = json_state["Time"] + " +0000" # make sure its UTC timestamp
    power = json_state["ENERGY"]["Power"]
    ts1 = Time.parse(last_ts)
    if (ts_now - ts1) > 600
      connector.update(state: :unknown)
    else  #connector is reachable, sync it's state with shadow
      connector.update(state: connector.shadow_state, power: power)
    end
    # Do something later
  end
end
