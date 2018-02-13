class CreateKpiFact < ActiveRecord::Migration
  def change
    create_table :kpi_facts do |t|
      t.references :student, index: true

      t.date    :start_date
      t.date    :end_date
      t.integer :log_count
      t.integer :like_count
      t.integer :comment_count
    end
  end
end
