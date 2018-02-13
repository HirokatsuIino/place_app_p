class AddNameColumnToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :name, :string
  end
end
