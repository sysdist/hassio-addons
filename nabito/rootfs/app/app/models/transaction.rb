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

# Transaction represents one continuous charging period,
# when the connector goes OFF->ON (charging)->OFF
class Transaction < ApplicationRecord
  belongs_to :connector

  after_initialize do
    if new_record?
      self.currency = 'EUR' # TODO: setting default currnecy for now
    end
  end

  def start
    TransactionUpdateJob.perform_later(self, 'start')
  end

  def finish
    TransactionUpdateJob.perform_later(self, 'finish')
  end

  def creditor
    User.find_by_id(creditor_id)
  end

  def debtor
    User.find_by_id(debtor_id)
  end



end
