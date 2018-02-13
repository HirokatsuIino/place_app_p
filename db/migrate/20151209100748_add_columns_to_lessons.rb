class AddColumnsToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :lesson_datetime, :datetime
    add_column :lessons, :lesson_type, :integer
  end
end
