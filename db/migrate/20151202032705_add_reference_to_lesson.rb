class AddReferenceToLesson < ActiveRecord::Migration
  def change
    add_reference :lessons, :report, index: true
  end
end
