class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.references :post, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer    :target_user_id, null: false, default: 0
      t.text       :content, null: false

      t.timestamps null: false
    end

    add_index :replies, :target_user_id
  end
end
