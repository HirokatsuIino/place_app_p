class CreateSentEmailEvents < ActiveRecord::Migration
  def change
    create_table :sent_email_events do |t|
      t.string     :event
      t.string     :message_id
      t.string     :sg_message_id
      t.timestamp  :occured_at

      t.timestamps null: false
    end
  end
end
