class CreateTeacherEditStudentProfileItem < ActiveRecord::Migration
  def change
    create_table :teacher_edit_student_profile_items do |t|
      t.references :teacher_edit_student_profile

      t.text :preferred_school
      t.text :preferred_school_reason
      t.text :school
      t.text :grade
      t.text :study_type
      t.text :hobby
      t.text :club
      t.text :learning
      t.text :goal
      t.text :problem
      t.text :subjects
      t.text :favorite_subjects
      t.text :dislike_subjects
      t.text :test
      t.text :comment

      t.timestamps null: false
    end
  end
end
