class AddTwitterToTeacherPosts < ActiveRecord::Migration
  def change
    add_column :teacher_posts, :twitter_post, :integer
  end
end
