class CreateStudentProfileImages < ActiveRecord::Migration
  def change
    create_table :student_profile_images do |t|
      t.references :student_profile, index: true, foreign_key: true
      t.integer :image_id, null: false

      t.timestamps null: false
    end
  end
end
