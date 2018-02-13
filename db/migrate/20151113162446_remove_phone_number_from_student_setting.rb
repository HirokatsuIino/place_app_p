class RemovePhoneNumberFromStudentSetting < ActiveRecord::Migration
  def change
    remove_column :student_settings, :phone_number
  end
end
