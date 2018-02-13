class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.string     :notifiable_type, null: false, default: ''
      t.integer    :notifiable_id,   null: false, default: 0
      t.timestamps :read_at

      t.timestamps null: false
    end
  end
end
