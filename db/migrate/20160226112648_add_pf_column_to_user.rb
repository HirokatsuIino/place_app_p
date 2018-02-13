class AddPfColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :payforward_id, :string
  end
end
