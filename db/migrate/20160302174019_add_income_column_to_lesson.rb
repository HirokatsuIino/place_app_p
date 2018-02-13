class AddIncomeColumnToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :income, :integer
  end
end
