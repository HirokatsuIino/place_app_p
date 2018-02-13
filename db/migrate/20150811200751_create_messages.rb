class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :from_user_id, null: false, default: 0
      t.integer :to_user_id,   null: false, default: 0
      t.text    :content,      null: false

      t.timestamps null: false
    end

    add_index :messages, :from_user_id
    add_index :messages, :to_user_id
  end
end
