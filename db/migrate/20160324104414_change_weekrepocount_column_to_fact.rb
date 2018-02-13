class ChangeWeekrepocountColumnToFact < ActiveRecord::Migration
  def change
    change_column :facts, :weekrepo_count, :string
  end
end
