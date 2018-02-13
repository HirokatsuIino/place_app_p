class AddTeacherIdToInterviewLog < ActiveRecord::Migration
  def change
    add_reference :interview_logs, :teacher, index: true
  end
end
