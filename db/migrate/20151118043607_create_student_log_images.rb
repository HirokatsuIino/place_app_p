class CreateStudentLogImages < ActiveRecord::Migration
  def change
    create_table :student_log_images do |t|
      t.references :student_log, index: true, foreign_key: true
      t.string :image_id, null: false

      t.timestamps null: false
    end
  end
end
