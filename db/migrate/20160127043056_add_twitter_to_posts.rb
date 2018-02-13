class AddTwitterToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :twitter_post, :integer
  end
end
