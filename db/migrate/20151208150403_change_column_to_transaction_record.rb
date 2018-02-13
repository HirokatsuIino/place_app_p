class ChangeColumnToTransactionRecord < ActiveRecord::Migration
  def change
    change_column :transaction_records, :teacher_id, :integer, null: false, default: 0
    change_column :transaction_records, :student_id, :integer, null: false, default: 0
  end
end
