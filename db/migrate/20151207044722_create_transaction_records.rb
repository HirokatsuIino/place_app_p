class CreateTransactionRecords < ActiveRecord::Migration
  def change
    create_table :transaction_records do |t|
      t.integer :lesson_id, null: false
      t.integer :student_id, null: false
      t.integer :teacher_id, null: false
      t.integer :amount, null: false
      t.text    :comment

      t.timestamps null: false
    end
  end
end
