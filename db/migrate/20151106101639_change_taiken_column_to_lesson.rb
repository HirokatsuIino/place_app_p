class ChangeTaikenColumnToLesson < ActiveRecord::Migration
  def change
    rename_column :lessons, :taiken, :trial 
  end
end
