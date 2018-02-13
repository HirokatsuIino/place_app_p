class CreateEmailDeliveries < ActiveRecord::Migration
  def change
    create_table :email_deliveries do |t|
      t.integer :from_user_id, null: false
      t.integer :to_user_id,   null: false
      t.string  :email_deliverable_type, null: false, default: ''
      t.integer :email_deliverable_id,   null: false, default: 0

      t.timestamps null: false
    end
  end
end
