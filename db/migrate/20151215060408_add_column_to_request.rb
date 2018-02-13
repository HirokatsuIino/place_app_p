class AddColumnToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :single, :boolean, null: false, default: false
  end
end
