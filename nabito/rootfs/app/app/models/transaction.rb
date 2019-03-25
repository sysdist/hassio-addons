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

class Transaction < ApplicationRecord
  belongs_to :connector

  def start
    update(status: "TNX_STARTED")
  end

  def finish
    total_kWhs = (meter_kWhs_finish - meter_kWhs_start).to_d
    a = total_kWhs * average_price_per_kWh
    update(kWhs_used: total_kWhs, amount: a, completed_at: Time.now.utc, status: "TNX_COMPLETE", date_posted: Date.today.to_s)
    
  end


end
