class AddTwitterToStudentSettings < ActiveRecord::Migration
  def change
    add_column :student_settings, :twitter_auth, :text
  end
end
