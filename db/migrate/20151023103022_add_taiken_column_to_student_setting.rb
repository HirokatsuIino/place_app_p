class AddTaikenColumnToStudentSetting < ActiveRecord::Migration
  def change
  	add_column :student_settings, :taiken_ticket, :integer, default: 2
  end
end
