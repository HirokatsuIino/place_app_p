class CreateTeacherNotes < ActiveRecord::Migration
  def change
    create_table :teacher_notes do |t|
      t.integer :teacher_id, null: false, default: 0
      t.text    :content,    null: false

      t.timestamps null: false
    end

    add_index :teacher_notes, :teacher_id
  end
end
