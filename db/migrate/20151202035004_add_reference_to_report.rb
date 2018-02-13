class AddReferenceToReport < ActiveRecord::Migration
  def change
    add_reference :student_reports, :lesson, index: true
  end
end
