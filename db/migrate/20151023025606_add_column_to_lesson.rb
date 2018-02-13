class AddColumnToLesson < ActiveRecord::Migration
  def change
  	add_column :lessons, :booked, :boolean
  	add_column :lessons, :canceled_at, :datetime
  	add_column :lessons, :open, :boolean
  	add_column :lessons, :pay, :integer
  	add_column :lessons, :paid, :boolean
  	add_column :lessons, :taiken, :boolean
  	add_column :lessons, :furikae_lesson, :integer
  	add_column :lessons, :start_time, :time
  	add_column :lessons, :end_time, :time
  	add_column :lessons, :youbi, :integer
  end
end
