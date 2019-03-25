json.extract! transaction, :id, :debtor_id, :creditor_id, :connector_id, :kWhs_used, :average_price_per_kWh, :currency, :amount, :date_posted, :completed_at, :status, :meter_kWhs_start, :meter_kWhs_finish, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
