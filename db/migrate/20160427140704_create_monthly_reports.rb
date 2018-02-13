class CreateMonthlyReports < ActiveRecord::Migration
  def change
    create_table :monthly_reports do |t|
      t.references :student, index: true
      t.string     :datetime_number
      t.string     :summary
      t.string     :point
      t.string     :message

      t.timestamps null: false
    end

    add_index :monthly_reports, :datetime_number
    add_index :monthly_reports, [:student_id, :datetime_number], unique: true
  end
end
