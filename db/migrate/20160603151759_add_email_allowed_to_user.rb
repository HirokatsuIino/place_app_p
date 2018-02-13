class AddEmailAllowedToUser < ActiveRecord::Migration
  def change
    add_column :users, :email_allowed, :boolean, default: true
  end
end
