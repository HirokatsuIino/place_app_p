class CreatePayforwardMessages < ActiveRecord::Migration
  def change
    create_table :payforward_messages do |t|
      t.references :payforward, index: true

      t.integer :sender_id
      t.integer :receiver_id
      t.text :content

      t.timestamps null: false
    end
  end
end
