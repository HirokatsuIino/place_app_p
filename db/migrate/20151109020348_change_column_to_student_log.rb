class ChangeColumnToStudentLog < ActiveRecord::Migration
  def change
    remove_column :student_logs, :study_time
    add_column    :student_logs, :study_time, :integer, default: 0
  end
end
