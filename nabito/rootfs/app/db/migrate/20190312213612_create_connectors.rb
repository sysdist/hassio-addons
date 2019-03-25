class CreateConnectors < ActiveRecord::Migration[5.2]
  def change
    create_table :connectors do |t|
      t.integer :owner
      t.string :name
      t.string :command_topic
      t.string :state_topic
      t.string :json_attributes_topic
      t.string :payload_on
      t.string :payload_off
      t.string :state_on
      t.string :state_off
      t.decimal :power
      t.integer :voltage
      t.decimal :i_max
      t.decimal :price_per_kWh
      t.integer :frequency
      t.string :state
      t.integer :current_user
      t.integer :current_tnx

      t.timestamps
    end
  end
end
