class AddPricingVersionColumnToTransactionRecord < ActiveRecord::Migration
  def change
    add_column :transaction_records, :pricing_version, :string
  end
end
