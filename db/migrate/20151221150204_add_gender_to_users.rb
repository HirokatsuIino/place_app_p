class AddGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string, null: false, default: 'male'
  end
end
