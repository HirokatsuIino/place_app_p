class CreateFollowMemo < ActiveRecord::Migration
  def change
    create_table :follow_memos do |t|
      t.references :teacher, index: true
      t.references :student, index: true
      t.integer    :target_teacher_id, null: false
      t.text       :content

      t.timestamps null: false
    end

    add_foreign_key :follow_memos, :users, column: :target_teacher_id
  end
end
