class RenameColumnsToStudentReports < ActiveRecord::Migration
  def change
    add_column :student_reports,    :topic,   :text
  	add_column :student_reports,    :trying,     :text
  	rename_column :student_reports, :plan,    :keep
  end

end
