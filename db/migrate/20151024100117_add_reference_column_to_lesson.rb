class AddReferenceColumnToLesson < ActiveRecord::Migration
  def change
  	add_reference :lessons, :lesson_request, index: true
  end
end
