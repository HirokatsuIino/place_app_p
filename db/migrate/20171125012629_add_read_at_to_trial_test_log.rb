class AddReadAtToTrialTestLog < ActiveRecord::Migration
  def change
    add_column :trial_test_logs, :read_at, :datetime    
  end
end
