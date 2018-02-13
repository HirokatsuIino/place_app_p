class AddBooleanColumnToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :single, :boolean, default: false, null: false
    remove_column :lessons, :booked
  end
end
