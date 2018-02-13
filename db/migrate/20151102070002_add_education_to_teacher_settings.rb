class AddEducationToTeacherSettings < ActiveRecord::Migration
  def change
    add_column :teacher_settings, :education, :string, null: false, default: ''
    add_column :teacher_settings, :grade,     :string, null: false, default: ''
  end
end
