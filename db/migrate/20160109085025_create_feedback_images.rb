class CreateFeedbackImages < ActiveRecord::Migration
  def change
    create_table :feedback_images do |t|
      t.string :image_id
      t.references :feedback, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
