class AddDeleteAtToTransactionRecords < ActiveRecord::Migration
  def change
    add_column :transaction_records, :deleted_at, :datetime
  end
end
