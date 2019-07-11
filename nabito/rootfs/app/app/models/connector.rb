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
#

class Connector < ApplicationRecord

  belongs_to :user

  enum state: { offline: 'OFFLINE', online: 'ONLINE', active: 'ACTIVE', error: 'ERROR' }
  #enum shadow_state: { offline: "OFFLINE", online: "ONLINE", active: "ACTIVE", error: "ERROR" }

  def in_use
    active?  
  end

  @json_state = nil

  def switch_on(active_user, tag_id = nil)

    mq = MqttClient.new
    mq.send_message(command_topic,payload_on)    
    
    kWhs = state_energy_total()

    tnx = Transaction.create(debtor_id: active_user.id, creditor_id: user_id,
                             connector_id: id,
                             average_price_per_kWh: price_per_kWh,
                             meter_kWhs_start: kWhs) #TODO: tags later , tag_id_start: tag_id)
    tnx.start()
    tnx.save()

    update(shadow_state: :active,current_user: active_user.id, current_tnx: tnx.id, current_kWh: kWhs)
    sync_state()

end

def switch_off(active_user, tag_id = nil)

  mq = MqttClient.new
  mq.send_message(command_topic,payload_off)    

  tnx = Transaction.find(current_tnx)
  kWhs = state_energy_total()
  tnx.meter_kWhs_finish = kWhs #TODO: tags later , tag_id_start: tag_id)tnx.tag_id_finish = tag_id
  tnx.save
  tnx.finish

  update(shadow_state: :online ,current_user: nil, current_tnx: nil)
  sync_state()
end

def mqtt_refresh_state()
  mq = MqttClient.new
  mq.send_message('cmnd/sonoff1/teleperiod',frequency)
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
  return @json_state["ENERGY"]["Total"] if @json_state 
  return nil
end

def power
  return @json_state["ENERGY"]["Power"] if @json_state 
  return nil
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
    update(state: :offline)
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
