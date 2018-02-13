class CreateInterviewLogItems < ActiveRecord::Migration
  def change
    create_table :interview_log_items do |t|
      t.references :interview_log

      t.text :how_to_know
      t.text :why
      t.text :expectation
      t.text :family_preferred_school
      t.text :family_study
      t.text :family_times
      t.text :understand
      t.text :trial_date
      t.text :comment
      t.text :problem
      t.text :transmission
      t.text :memo

      t.timestamps null: false
    end
  end
end
