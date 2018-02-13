class AddStudyTimeToStudentReport < ActiveRecord::Migration
  def change
    add_column :student_reports, :study_time, :integer
  end
end
