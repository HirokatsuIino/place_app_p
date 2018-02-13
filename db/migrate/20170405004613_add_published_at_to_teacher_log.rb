class AddPublishedAtToTeacherLog < ActiveRecord::Migration
  def change
    add_column :teacher_logs, :published_at, :datetime
  end
end
