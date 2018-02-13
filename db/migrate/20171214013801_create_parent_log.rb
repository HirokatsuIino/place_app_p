class CreateParentLog < ActiveRecord::Migration
  def change
    create_table :parent_logs do |t|
      t.references :student, index: true
      t.references :teacher, index: true
      t.references :lesson,  index: true

      t.text    :recent_news
      t.text    :keep
      t.text    :problem
      t.text    :try
      t.text    :question
      t.text    :last_greeting
      t.text    :comment
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
