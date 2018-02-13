class CreateExamSchoolLog < ActiveRecord::Migration
  def change
    create_table :exam_school_logs do |t|
      t.references :student, index: true
      t.references :teacher, index: true
      t.text       :exam_school
      t.integer    :exam_year
      t.integer    :exam_month
      t.integer    :exam_day
      t.integer    :announce_year
      t.integer    :announce_month
      t.integer    :announce_day
      t.text       :result

      t.datetime   :read_at
      t.datetime   :deleted_at
      t.timestamps null: false
    end
  end
end
