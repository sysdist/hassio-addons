class AddCurrentkwhToConnector < ActiveRecord::Migration[5.2]
  def change
    add_column :connectors, :current_kWh, :decimal
  end
end
