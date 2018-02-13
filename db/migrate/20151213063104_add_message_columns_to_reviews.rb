class AddMessageColumnsToReviews < ActiveRecord::Migration
  def change
    add_column :teacher_reviews, :message_to_teacher, :text
    add_column :teacher_reviews, :message_to_company, :text
    add_column :teacher_reviews, :rate1, :integer, null: false, default: 0
    add_column :teacher_reviews, :rate2, :integer, null: false, default: 0
    add_column :teacher_reviews, :rate3, :integer, null: false, default: 0
    add_column :teacher_reviews, :rate4, :integer, null: false, default: 0
    add_column :teacher_reviews, :rate5, :integer, null: false, default: 0
  end
end
