class AddFromTeacherColumnToTeacherReview < ActiveRecord::Migration
  def change
    add_column :teacher_reviews, :message_from_teacher, :text
  end
end
