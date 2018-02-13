class RemoveColumnFromLesson < ActiveRecord::Migration
  def change
  	remove_column :lessons, :lesson_request_id
  end
end
