class AddPermissionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :permission, :integer, null: false, default: 0
  end
end
