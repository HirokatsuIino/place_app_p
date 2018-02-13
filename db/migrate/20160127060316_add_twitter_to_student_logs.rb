class AddTwitterToStudentLogs < ActiveRecord::Migration
  def change
    add_column :student_logs, :twitter_post, :integer
    add_column :student_logs, :twitter_comment, :text
  end
end
