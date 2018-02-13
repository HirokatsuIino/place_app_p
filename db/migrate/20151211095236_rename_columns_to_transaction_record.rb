class RenameColumnsToTransactionRecord < ActiveRecord::Migration
  def change
    rename_column :transaction_records, :student_id, :payer_id
    rename_column :transaction_records, :teacher_id, :receiver_id
  end
end
