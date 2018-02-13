class RenameColumnToTransactionRecord < ActiveRecord::Migration
  def change
    rename_column :transaction_records, :commision, :commission
  end
end
