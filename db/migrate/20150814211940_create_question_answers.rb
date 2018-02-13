class CreateQuestionAnswers < ActiveRecord::Migration
  def change
    create_table :question_answers do |t|
      t.references :question, index: true, foreign_key: true
      t.integer    :teacher_id, null: false, default: 0
      t.text       :content,    null: false

      t.timestamps null: false
    end

    add_index :question_answers, :teacher_id
  end
end
