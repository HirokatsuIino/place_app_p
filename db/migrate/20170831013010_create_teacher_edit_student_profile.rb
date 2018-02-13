class CreateTeacherEditStudentProfile < ActiveRecord::Migration
  def change
    create_table :teacher_edit_student_profiles do |t|
      t.references :teacher,       index: true
      t.references :student,       index: true
      t.references :interview_log
      t.references :student_profile
      t.text       :content

      t.timestamps null: false
    end
  end
end
