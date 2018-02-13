class AddDeletedAtToReposts < ActiveRecord::Migration
  def change
    add_column :reposts, :deleted_at, :datetime
    add_index :reposts, :deleted_at
  end
end
