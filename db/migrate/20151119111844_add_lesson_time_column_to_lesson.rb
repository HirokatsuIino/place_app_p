class AddLessonTimeColumnToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :lesson_time, :integer
    add_column :lessons, :interval, :integer
  end
end
