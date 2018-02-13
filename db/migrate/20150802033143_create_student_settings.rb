class CreateStudentSettings < ActiveRecord::Migration
  def change
    create_table :student_settings do |t|
      t.integer :student_id, null: false, default: 0
      t.string  :name
      t.string  :skype_id
      t.string  :phone_number

      t.timestamps null: false
    end

    add_index :student_settings, :student_id
  end
end
