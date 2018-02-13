class AddTwitterToReposts < ActiveRecord::Migration
  def change
    add_column :reposts, :twitter_post, :integer
  end
end
