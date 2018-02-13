class CreateInterviewLogs < ActiveRecord::Migration
  def change
    create_table :interview_logs do |t|
      t.references :student, index: true
      t.text       :content

      t.timestamps null: false
    end
  end
end
