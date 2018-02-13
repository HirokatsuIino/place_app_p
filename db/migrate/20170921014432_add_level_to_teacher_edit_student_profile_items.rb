class AddLevelToTeacherEditStudentProfileItems < ActiveRecord::Migration
  def change
    add_column :teacher_edit_student_profile_items, :level, :integer, default: 3
  end
end
