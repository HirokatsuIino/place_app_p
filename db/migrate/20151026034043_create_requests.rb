class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :lesson,  index: true
      t.references :student, index: true
      t.references :teacher, index: true
      t.string :requeststatus, default: "request"

      t.timestamps null: false
    end
  end
end
