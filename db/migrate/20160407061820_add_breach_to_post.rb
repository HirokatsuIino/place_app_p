class AddBreachToPost < ActiveRecord::Migration
  def change
    add_column :posts, :breach, :boolean, default: false
  end
end
