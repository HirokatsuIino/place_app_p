class AddIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :skype_id,  :string, null: false, default: ''
    add_column :users, :senpre_id, :string, null: false, default: ''

    add_index :users, :skype_id
    add_index :users, :senpre_id
  end
end
