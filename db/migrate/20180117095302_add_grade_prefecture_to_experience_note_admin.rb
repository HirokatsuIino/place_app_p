class AddGradePrefectureToExperienceNoteAdmin < ActiveRecord::Migration
  def change
    add_column :experience_note_admins, :grade, :string, null: false, default: ''
    add_column :experience_note_admins, :prefecture, :string, null: false, default: ''
  end
end
