class CreateMonthlyFees < ActiveRecord::Migration
  def change
    create_table :monthly_fees do |t|
      t.references :user,  foreign_key: true
      t.integer    :year,  null: false
      t.integer    :month, null: false
      t.string     :comment

      t.timestamps null: false
    end
  end
end
