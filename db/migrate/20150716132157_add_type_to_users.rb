class AddTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :type,     :string, null: false, default: ''
    add_column :users, :name,     :string
    add_column :users, :image_id, :string
  end
end
