class AddColumnsToStudentSettings < ActiveRecord::Migration
  def change
    add_column :student_settings, :grade, :string, null: false, default: ''
    add_column :student_settings, :prefecture, :string, null: false, default: ''
    add_column :student_settings, :self_intro, :string
  end
end
