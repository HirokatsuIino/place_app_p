class ChangeColumnToLesson < ActiveRecord::Migration
  def change
  	change_column :lessons, :open, :boolean, default: true
  end
end
