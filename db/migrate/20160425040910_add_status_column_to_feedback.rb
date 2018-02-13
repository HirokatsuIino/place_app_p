class AddStatusColumnToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :tantou, :string
    add_column :feedbacks, :status, :string, default: "未連絡"
  end
end
