class AddCommentColumnToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :comment, :string
  end
end
