class AddColumnToStudentLog < ActiveRecord::Migration
  def change
  add_column :student_logs, :day, :date 
  add_column :student_logs, :study_time, :time
  add_column :student_logs, :comment, :string
  add_column :student_logs, :open, :boolean, default: true
  end
end
