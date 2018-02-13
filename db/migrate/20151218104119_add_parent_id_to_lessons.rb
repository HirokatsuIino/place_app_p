class AddParentIdToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :parent_id, :integer, null: false, default: 0
  end
end
