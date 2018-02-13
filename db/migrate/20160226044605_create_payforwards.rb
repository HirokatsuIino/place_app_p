class CreatePayforwards < ActiveRecord::Migration
  def change
    create_table :payforwards do |t|
      t.string   :comment
      t.integer  :introducer_id,      default: false, null: false
      t.boolean  :introducer_parent,  default: false, null: false
      t.integer  :introduced_id,      default: false, null: false
      t.boolean  :introduced_parent,  default: false, null: false
      t.datetime :introduced_registrated_at
      t.boolean  :sent_to_introducer, default: false
      t.boolean  :sent_to_introduced, default: false

      t.timestamps null: false
    end
  end
end
