class AddSubstitutedLessonIdToLesson < ActiveRecord::Migration
  def change
    add_reference :lessons, :substituted_lesson, index: true
  end
end
