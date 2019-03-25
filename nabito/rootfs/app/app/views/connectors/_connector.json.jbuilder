json.extract! connector, :id, :owner, :name, :command_topic, :state_topic, :json_attributes_topic, :payload_on, :payload_off, :state_on, :state_off, :power, :voltage, :i_max, :price_per_kWh, :frequency, :state, :current_user, :current_tnx, :created_at, :updated_at
json.url connector_url(connector, format: :json)
