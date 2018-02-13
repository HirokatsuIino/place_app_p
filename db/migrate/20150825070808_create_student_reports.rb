class CreateStudentReports < ActiveRecord::Migration
  def change
    create_table :student_reports do |t|
      t.integer :student_id, null: false, default: 0
      t.text    :content,    null: false

      t.timestamps null: false
    end

    add_index :student_reports, :student_id
  end
end
