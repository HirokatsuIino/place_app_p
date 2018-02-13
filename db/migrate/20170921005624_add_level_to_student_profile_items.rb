class AddLevelToStudentProfileItems < ActiveRecord::Migration
  def change
    add_column :student_profile_items, :level, :integer, default: 3
  end
end
