class AddShadowStatusToConnector < ActiveRecord::Migration[5.2]
  def change
    add_column :connectors, :shadow_state, :string
  end
end
