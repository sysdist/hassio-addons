class ConnectorSyncJob < ApplicationJob
  queue_as :default

  def perform(*args)
    c_id = args[0]
    connector = Connector.find(c_id)
    mq = MqttClient.new
    mqtt_state = mq.get_message(connector.json_attributes_topic)
    json_state = JSON.parse(mqtt_state)
    state = mq.get_message(connector.state_topic)

    ts_now = Time.now.utc
    puts "UTC time now: #{ts_now}"
    puts "connector time: #{json_state['Time']}"
    last_ts = json_state['Time'] + ' +0000' # make sure its UTC timestamp
    power = json_state['ENERGY']['Power']
    kwhs = json_state['ENERGY']['Total']
    ts1 = Time.parse(last_ts)

    sync_period = ENV['SYNC_PERIOD'] || 120
    if (ts_now - ts1) > sync_period
      connector.update(state: :unknown)
    else # connector is reachable, sync it's state with shadow
      connector.update(state: state, power: power,
                       json_state: json_state, last_timestamp: ts1,
                       current_kWh: kwhs)
    end
  end
end
