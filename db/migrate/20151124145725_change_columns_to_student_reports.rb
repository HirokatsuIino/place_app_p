class ChangeColumnsToStudentReports < ActiveRecord::Migration
  def up
  	change_column :student_reports, :content, :text, null: false, default: '週間レポートを作成しました。'
  	change_column :student_reports, :comment, :text, null: false, default: ''
  end

  def down
  	change_column :student_reports, :content, :text, null: false
  	change_column :student_reports, :comment, :text, null: false
  end
end
