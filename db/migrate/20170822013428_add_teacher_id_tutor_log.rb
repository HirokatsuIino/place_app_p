class AddTeacherIdTutorLog < ActiveRecord::Migration
  def change
    add_reference :tutor_logs, :teacher, index: true
  end
end
