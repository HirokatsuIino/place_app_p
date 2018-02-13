class RenameTaikenTicketColumnOfStudentSetting < ActiveRecord::Migration
  def change
  	rename_column :student_settings, :taiken_ticket, :trial_ticket 
  end
end
