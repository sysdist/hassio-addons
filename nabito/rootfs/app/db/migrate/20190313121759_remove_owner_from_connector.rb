class RemoveOwnerFromConnector < ActiveRecord::Migration[5.2]
  def change
    remove_column :connectors, :owner, :integer
    remove_reference :connectors, :owner, index:true, foreign_key: true
    add_reference :connectors, :user, index: true
  end
end
