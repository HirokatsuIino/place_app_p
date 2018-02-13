class CreateMailAfterLessons < ActiveRecord::Migration
  def change
    create_table :mail_after_lessons do |t|
      t.references :lesson, index: true

      t.datetime   :deliver_time
      t.boolean    :mail_delivered, default: false

      t.timestamps null: false
    end
  end
end
