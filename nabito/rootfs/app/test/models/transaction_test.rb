# == Schema Information
#
# Table name: transactions
#
#  id                    :integer          not null, primary key
#  debtor_id             :integer
#  creditor_id           :integer
#  connector_id          :integer
#  kWhs_used             :decimal(, )
#  average_price_per_kWh :decimal(, )
#  currency              :string
#  amount                :decimal(, )
#  date_posted           :date
#  completed_at          :datetime
#  status                :string
#  meter_kWhs_start      :decimal(, )
#  meter_kWhs_finish     :decimal(, )
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
