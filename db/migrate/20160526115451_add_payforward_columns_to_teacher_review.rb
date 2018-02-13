class AddPayforwardColumnsToTeacherReview < ActiveRecord::Migration
  def change
    add_column :teacher_reviews, :message_to_pf_introduced, :text
    add_column :teacher_reviews, :message_to_pf_introducer, :text
  end
end
