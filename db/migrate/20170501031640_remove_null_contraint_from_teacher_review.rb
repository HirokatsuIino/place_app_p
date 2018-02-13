class RemoveNullContraintFromTeacherReview < ActiveRecord::Migration
  def change
    change_column :teacher_reviews, :rate1, :integer, null: true
    change_column :teacher_reviews, :rate2, :integer, null: true
    change_column :teacher_reviews, :rate3, :integer, null: true
    change_column :teacher_reviews, :rate4, :integer, null: true
    change_column :teacher_reviews, :rate5, :integer, null: true
  end
end