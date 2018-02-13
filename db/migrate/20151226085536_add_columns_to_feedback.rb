class AddColumnsToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :iphone, :integer
    add_column :feedbacks, :models, :string
  end
end
