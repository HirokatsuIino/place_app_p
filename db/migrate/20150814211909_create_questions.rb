class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :student_id, null: false, default: 0
      t.text    :content, null: false

      t.timestamps null: false
    end

    add_index :questions, :student_id
  end
end
