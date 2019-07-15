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

require 'test_helper'

class ConnectorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
