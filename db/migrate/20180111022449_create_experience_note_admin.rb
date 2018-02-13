class CreateExperienceNoteAdmin < ActiveRecord::Migration
  def change
    create_table :experience_note_admins do |t|
      t.references  :experience_note
      t.integer  :user_id
      t.integer  :period
      t.text     :situation
      t.text     :reason
      t.text     :change
      t.text     :ambition
      t.datetime :published_at
      t.boolean  :published, default: false, null: false
  
      t.timestamps null: false
    end
  end
end