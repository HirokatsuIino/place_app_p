class AddWeekrepoNeedlessColumnToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :weekrepo_need, :boolean, default: true
  end
end
