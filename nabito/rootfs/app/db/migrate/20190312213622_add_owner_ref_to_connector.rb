class AddOwnerRefToConnector < ActiveRecord::Migration[5.2]
  def change
    add_reference :connectors, :owner, foreign_key: { to_table: :users }
  end
end
