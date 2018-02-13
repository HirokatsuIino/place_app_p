class AddEmailToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :email, :string, null: false, default: ""
  end
end
