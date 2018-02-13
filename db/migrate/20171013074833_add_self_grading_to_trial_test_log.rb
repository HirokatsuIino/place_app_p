class AddSelfGradingToTrialTestLog < ActiveRecord::Migration
  def change
    add_column :trial_test_logs, :self_grading, :text
  end
end
