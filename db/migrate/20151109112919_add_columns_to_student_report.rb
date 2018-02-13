class AddColumnsToStudentReport < ActiveRecord::Migration
  def change
    add_column :student_reports, :date,    :date
    add_column :student_reports, :review,  :string, limit: 255
    add_column :student_reports, :plan,    :text
    add_column :student_reports, :comment, :text
    add_column :student_reports, :problem, :text
  end
end
