class CreateTeacherSettings < ActiveRecord::Migration
  def change
    create_table :teacher_settings do |t|
      t.integer :teacher_id, null: false, default: 0
      t.integer :fee
      t.string  :message

      t.timestamps null: false
    end

    add_index :teacher_settings, :teacher_id
  end
end
