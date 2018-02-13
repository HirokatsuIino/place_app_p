class CreateTutorLog < ActiveRecord::Migration
  def change
    create_table :tutor_logs do |t|
      t.references :student
      t.integer    :number, null: false, default: 1
      t.boolean    :draft,  null: false, default: true
      t.boolean    :notification_sent, null: false, default: false

      t.timestamps null: false
    end

    add_foreign_key :tutor_logs, :users, column: :student_id
  end
end
