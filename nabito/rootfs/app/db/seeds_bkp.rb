User.create!([
  {email: "admin@example.com",
     password: "changeme",
     password_confirmation: "changeme",
     reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil}
])
Connector.create!([
  {name: "Sonoff1", command_topic: "cmnd/sonoff1/power", state_topic: "stat/sonoff1/POWER", json_attributes_topic: "tele/sonoff1/SENSOR",
   payload_on: "ON", payload_off: "OFF", state_on: "ON", state_off: "OFF", power: "3.6", voltage: 230, i_max: "16.0", price_per_kWh: "0.1",
   frequency: 60, state: "", current_user: nil, current_tnx: nil, user_id: 1}
])


#encrypted_password: "$2a$11$tlMOHt5yxjospbHMvrby9euf2n2tqyTKul.eYI5qmdxsQ8Xw/n5US", 