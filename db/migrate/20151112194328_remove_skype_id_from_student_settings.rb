class RemoveSkypeIdFromStudentSettings < ActiveRecord::Migration
  def change
    remove_column :student_settings, :skype_id
  end
end
