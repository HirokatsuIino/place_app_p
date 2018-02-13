class CreateStudentLogs < ActiveRecord::Migration
  def change
    create_table :student_logs do |t|
      t.integer :student_id, null: false, default: 0
      t.text    :content,    null: false

      t.timestamps null: false
    end

    add_index :student_logs, :student_id
  end
end
