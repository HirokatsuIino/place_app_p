class AddActionedForStudentLogToUsers < ActiveRecord::Migration
  def change
    add_column :users, :student_log_id, :integer
  end
end
