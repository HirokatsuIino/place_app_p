class AddNameToTeacherSettings < ActiveRecord::Migration
  def change
    add_column :teacher_settings, :name, :string
  end
end
