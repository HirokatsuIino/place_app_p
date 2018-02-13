class CreateTeacherLogs < ActiveRecord::Migration
  def change
    create_table :teacher_logs do |t|
      t.references :teacher, index: true
      t.references :student, index: true
      t.references :lesson, index: true
      t.text :log_content, null: false
      t.text :saved_content
      t.integer :self_score

      t.timestamps null: false
    end
  end
end
