class CreateReposts < ActiveRecord::Migration
  def change
    create_table :reposts do |t|
      t.references :post, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text       :content, null: false
      
      t.timestamps null: false
    end
  end
end
