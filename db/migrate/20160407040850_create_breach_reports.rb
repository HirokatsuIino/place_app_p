class CreateBreachReports < ActiveRecord::Migration
  def change
    create_table :breach_reports do |t|
      t.integer    :reporter_id, null: false
      t.references :post,        index: true
      t.text       :comment,     null: false, default: ''
      t.datetime   :read_at

      t.timestamps null: false
    end

    add_index :breach_reports, :reporter_id
  end
end
