class AddDeletedAtToTeacherReview < ActiveRecord::Migration
  def change
    add_column :teacher_reviews, :deleted_at, :datetime
  end
end
