class AddJsonToConnector < ActiveRecord::Migration[5.2]
  def change
    add_column :connectors, :json_state, :json
    add_column :connectors, :last_timestamp, :datetime
  end
end
