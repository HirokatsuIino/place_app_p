class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.references :student, index: true
      t.references :teacher, index: true
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps null: false
    end
  end
end
