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
#

class Connector < ApplicationRecord

  belongs_to :user

  enum state: { offline: "OFFLINE", online: "ONLINE", active: "ACTIVE", error: "ERROR" }

  def in_use
    active?  
  end

  @json_state = nil

  def switch_on(active_user, tag_id = nil)

    mq = MqttClient.new
    mq.send_message(command_topic,payload_on)    
    
    kWhs = state_energy_total()

    tnx = Transaction.create(debtor_id: active_user.id, creditor_id: user_id, connector_id: self.id,
                              average_price_per_kWh: price_per_kWh, meter_kWhs_start: kWhs) #TODO: tags later , tag_id_start: tag_id)
    tnx.start()
    tnx.save()

    update(state: :active,current_user: active_user.id, current_tnx: tnx.id, current_kWh: kWhs)

end

def switch_off(active_user, tag_id = nil)

  mq = MqttClient.new
  mq.send_message(command_topic,payload_off)    

  tnx = Transaction.find(current_tnx)
  kWhs = state_energy_total()
  tnx.meter_kWhs_finish = kWhs #TODO: tags later , tag_id_start: tag_id)tnx.tag_id_finish = tag_id
  tnx.save
  tnx.finish

  update(state: :online ,current_user: nil, current_tnx: nil)
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
  return @json_state["ENERGY"]["Total"] if @json_state 
  return nil
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
