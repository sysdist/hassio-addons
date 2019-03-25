class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :debtor_id
      t.integer :creditor_id
      t.references :connector, foreign_key: true
      t.decimal :kWhs_used
      t.decimal :average_price_per_kWh
      t.string :currency
      t.decimal :amount
      t.date :date_posted
      t.datetime :completed_at
      t.string :status
      t.decimal :meter_kWhs_start
      t.decimal :meter_kWhs_finish

      t.timestamps
    end
  end
end
