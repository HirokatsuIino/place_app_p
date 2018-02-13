class CreateParentGreetingLog < ActiveRecord::Migration
  def change
    create_table :parent_greeting_logs do |t|
      t.references :student, index: true
      t.references :teacher, index: true

      t.text :working_reason
      t.text :coaching_reason
      t.text :experience
      t.text :student_impression
      t.text :about_student
      t.text :announce
      t.text :team
      t.text :about_interview
      t.integer :parent
      t.integer :relation
      t.integer :lesson
      t.integer :prevent_withdrawal
      t.integer :exam_schools
      t.integer :mindset

      t.datetime   :published_at
      t.datetime   :deleted_at
      t.timestamps null: false
    end
  end
end
