class AddParentEmailAddressToStudentSetting < ActiveRecord::Migration
  def change
    add_column :student_settings, :parent_email, :string
  end
end
