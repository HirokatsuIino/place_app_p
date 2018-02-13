class CreateTeacherPostImages < ActiveRecord::Migration
  def change
    create_table :teacher_post_images do |t|
      t.references :teacher_post, index: true, foreign_key: true
      t.string :image_id, null: false

      t.timestamps null: false
    end
  end
end
