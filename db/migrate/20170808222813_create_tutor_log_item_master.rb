class CreateTutorLogItemMaster < ActiveRecord::Migration
  def change
    create_table :tutor_log_item_masters do |t|
      t.string  :name,             null: false
      t.text    :title
      t.text    :explanation,      null: false
      t.integer :tutor_log_number, null: false
      t.integer :order,            null: false
      t.boolean :textfield_required, null: false, default: false

      t.timestamps null: false
    end
  end
end
