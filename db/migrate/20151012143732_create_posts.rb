class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string  :event_type

      t.integer :poster_id
      t.string  :poster_type

      t.integer :post_content_id
      t.string  :post_content_type

      t.timestamps null: false
    end

    add_index :posts, :poster_id
    add_index :posts, :poster_type

    add_index :posts, :post_content_id
    add_index :posts, :post_content_type
    add_index :posts, [:post_content_id, :post_content_type], unique: true
  end
end
