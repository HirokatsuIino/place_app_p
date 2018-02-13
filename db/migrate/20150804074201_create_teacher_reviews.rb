class CreateTeacherReviews < ActiveRecord::Migration
  def change
    create_table :teacher_reviews do |t|
      t.integer :teacher_id, null: false, default: 0
      t.integer :student_id, null: false, default: 0
      t.text    :content
      t.integer :rate

      t.timestamps null: false
    end

    add_index :teacher_reviews, :teacher_id
    add_index :teacher_reviews, :student_id
  end
end
