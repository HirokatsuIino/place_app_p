class CreateLogLevel < ActiveRecord::Migration
  def change
    create_table :log_levels do |t|
      t.integer :levelable_id
      t.string  :levelable_type

      t.integer :cycle_level,  null: false, default: 1
      t.integer :lesson_level, null: false, default: 1
      t.integer :log_level,    null: false, default: 1
      t.integer :report_level, null: false, default: 1

      t.timestamps null: false
    end

    add_index :log_levels, [:levelable_id, :levelable_type]
  end
end
