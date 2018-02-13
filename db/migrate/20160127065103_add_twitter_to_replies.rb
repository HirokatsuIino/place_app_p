class AddTwitterToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :twitter_post, :integer
  end
end
