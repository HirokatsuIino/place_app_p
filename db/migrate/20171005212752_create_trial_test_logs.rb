class CreateTrialTestLogs < ActiveRecord::Migration
  def change
    create_table :trial_test_logs do |t|
      t.references :student, index: true
      t.integer :year
      t.integer :month
      t.integer :day
      t.text    :name
      t.integer :test_type, default: 0
      t.text    :total_deviation_value
      t.text    :each_deviation_value
      t.text    :judgment
      t.text    :impression
      t.boolean :carried_out, default: false

      t.timestamps null: false
    end
  end
end
