# == Schema Information
#
# Table name: connectors
#
#  id                    :integer          not null, primary key
#  name                  :string
#  command_topic         :string
#  state_topic           :string
#  json_attributes_topic :string
#  payload_on            :string
#  payload_off           :string
#  state_on              :string
#  state_off             :string
#  power                 :decimal(, )
#  voltage               :integer
#  i_max                 :decimal(, )
#  price_per_kWh         :decimal(, )
#  frequency             :integer
#  state                 :string
#  current_user          :integer
#  current_tnx           :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :integer
#  current_kWh           :decimal(, )
#  shadow_state          :string
#  json_state            :json
#  last_timestamp        :datetime
#

# Generic class for connectors - currently only Sonoff Pow2 implemented
class Connector < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :command_topic, presence: true
  validates :state_topic, presence: true
  validates :json_attributes_topic, presence: true
  validates :price_per_kWh, numericality: true

  enum state: { unknown: 'UNKNOWN', off: 'OFF', on: 'ON', error: 'ERROR' }

  after_initialize do
    if new_record?
      # default values for new record
      self.state = 'UNKNOWN'
      self.shadow_state = 'OFF'
      self.frequency = 60
      self.payload_on = 'ON'
      self.payload_off = 'OFF'
      self.state_on = 'ON'
      self.state_off = 'OFF'
      self.i_max = 16
      self.voltage = 230
    end
  end

  def in_use
    on?
  end

  def ping_topic
    'cmnd/' + name + '/teleperiod'
  end

  def switch_on(active_user, tag_id = nil)
    ConnectorRequestJob.perform_later(command_topic, payload_on)
    # TODO: tags later , tag_id_start: tag_id
    tnx = Transaction.create!(debtor_id: active_user.id, creditor_id: user_id,
                             connector_id: id,
                             average_price_per_kWh: price_per_kWh)

    tnx.save

    ConnectorRequestJob.perform_later(ping_topic, frequency)
    ConnectorSyncJob.perform_later(id)
    tnx.start

    update(shadow_state: :on, current_user: active_user.id,
           current_tnx: tnx.id)
  end

  def switch_off(active_user, tag_id = nil)
    ConnectorRequestJob.perform_later(command_topic, payload_off)
    ConnectorRequestJob.perform_later(ping_topic, frequency)
    ConnectorSyncJob.perform_later(id)
    tnx = Transaction.find(current_tnx)
    tnx.finish
    update(shadow_state: :off, current_user: nil, current_tnx: nil)
  end

  def mqtt_refresh_state()
    mq = MqttClient.new
    mq.send_message(ping_topic, frequency)
  end

  def mqtt_get_state()
    mq = MqttClient.new
    mqtt_state =  mq.get_message(json_attributes_topic)
    @json_state = JSON.parse(mqtt_state)
  end

  def state_energy_total
    mqtt_get_state()
    energy_total()
  end

  def energy_total
    return json_state['ENERGY']['Total'] if json_state
  end




  #tele/sonoff1/SENSOR 
  #{"Time":"2019-06-18T08:57:19","ENERGY":{"TotalStartTime":"2019-01-30T13:44:46","Total":38.854,"Yesterday":0.354,"Today":0.000,"Period":0,"Power":0,"ApparentPower":0,"ReactivePower":0,"Factor":0.00,"Voltage":0,"Current":0.000}}

  def sync_state()
    mqtt_get_state()
    ts_now = Time.now.utc
    puts "UTC time now: " + ts_now.to_s
    puts "connector time: " + @json_state["Time"] 
    last_ts = @json_state["Time"] + " +0000" #make sure its UTC timestamp
    ts1 = Time.parse(last_ts)
    if (ts_now - ts1) > 600
      update(state: :unknown)
    else  #connector is reachable, sync it's state with shadow
      update(state: shadow_state)
    end

  end

  def meter_values(iot_client)
      shadow = iot_client.get_thing_shadow({
        thing_name: box.aws_thing_name
      })
      o = JSON[shadow.payload.string]
      meter_values = o["state"]["reported"]["connectors"][name]["meter_values"]
      return meter_values 
  end





end
