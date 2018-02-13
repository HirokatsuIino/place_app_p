class CreateSentEmails < ActiveRecord::Migration
  def change
    create_table :sent_emails do |t|
      t.references :sender,    index: true
      t.references :recipient, index: true
      t.string :sender_nickname
      t.string :sender_email
      t.string :recipient_nickname
      t.string :recipient_email
      t.string :subject
      t.string :header
      t.string :body
      t.string :message_id
      t.boolean :delivered, default: true

      t.timestamps null: false
    end
  end
end
