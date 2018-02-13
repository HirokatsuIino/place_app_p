class AddDeletedAtToStudentLogs < ActiveRecord::Migration
  def change
    add_column :student_logs, :deleted_at, :datetime
    add_index :student_logs, :deleted_at
  end
end
