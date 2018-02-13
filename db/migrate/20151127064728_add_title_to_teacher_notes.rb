class AddTitleToTeacherNotes < ActiveRecord::Migration
  def change
    add_column :teacher_notes, :title, :string, null: false, default: ""
  end
end
