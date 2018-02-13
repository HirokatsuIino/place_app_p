class CreateMessageImages < ActiveRecord::Migration
  def change
    create_table :message_images do |t|
      t.string :image_id
      t.references :message, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
