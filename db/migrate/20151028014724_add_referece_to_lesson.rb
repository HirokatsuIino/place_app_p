class AddRefereceToLesson < ActiveRecord::Migration
  def change
  	add_reference :lessons, :request, index: true
  end
end
