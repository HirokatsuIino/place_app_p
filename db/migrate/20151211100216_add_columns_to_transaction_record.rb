class AddColumnsToTransactionRecord < ActiveRecord::Migration
  def change
    add_column :transaction_records, :admin_id, :integer
    add_column :transaction_records, :status, :integer
    add_column :transaction_records, :commision, :integer
  end
end
