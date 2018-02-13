class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :follower_id, null: false, default: 0
      t.integer :followed_id, null: false, default: 0
      t.boolean :private,     null: false, defautl: true

      t.timestamps null: false
    end

    add_index :follows, :follower_id
    add_index :follows, :followed_id
    add_index :follows, [:follower_id, :followed_id], unique: true
  end
end
