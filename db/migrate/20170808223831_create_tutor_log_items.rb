class CreateTutorLogItems < ActiveRecord::Migration
  def change
    create_table :tutor_log_items do |t|
      t.references :tutor_log
      t.references :tutor_log_item_master

      t.text       :content, null: false, default: ''

      t.timestamps null: false
    end
  end
end
