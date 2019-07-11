User.create!([
  {email: "admin@example.com", 
    password: "changeme",
    password_confirmation: "changeme",
    admin: true,
    reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil},
  {email: "user1@example.com", 
    password: "changeme",
    password_confirmation: "changeme",
    admin: false,
    reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil}
])
Connector.create!([
  {name: "sonoff1", 
    command_topic: "cmnd/sonoff1/power", 
    state_topic: "stat/sonoff1/POWER",
    json_attributes_topic: "tele/sonoff1/SENSOR", 
    payload_on: "ON", payload_off: "OFF", state_on: "ON", state_off: "OFF", power: "3.6", 
    voltage: 230, i_max: "16.0", price_per_kWh: "0.1", frequency: 60, state: "offline", 
    current_user: nil, current_tnx: nil, user_id: 1, current_kWh: "10.291"}
])
Transaction.create!([
  {debtor_id: 1, creditor_id: 1, connector_id: 1, kWhs_used: "0.096", average_price_per_kWh: "0.1", currency: nil, amount: "0.0096", date_posted: "2019-03-15", completed_at: "2019-03-15 22:05:39", status: "TNX_COMPLETE", meter_kWhs_start: "10.291", meter_kWhs_finish: "10.387"},
  {debtor_id: 2, creditor_id: 1, connector_id: 1, kWhs_used: "0.096", average_price_per_kWh: "0.1", currency: nil, amount: "0.0096", date_posted: "2019-03-15", completed_at: "2019-03-15 22:05:39", status: "TNX_COMPLETE", meter_kWhs_start: "10.291", meter_kWhs_finish: "10.387"}
])
