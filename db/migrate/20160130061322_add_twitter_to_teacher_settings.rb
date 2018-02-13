class AddTwitterToTeacherSettings < ActiveRecord::Migration
  def change
    add_column :teacher_settings, :twitter_auth, :text
  end
end
