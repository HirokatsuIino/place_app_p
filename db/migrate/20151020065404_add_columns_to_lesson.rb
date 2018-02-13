class AddColumnsToLesson < ActiveRecord::Migration
  def change
  	add_column :lessons, :time, :time 
  	add_column :lessons, :date, :date
  end
end
