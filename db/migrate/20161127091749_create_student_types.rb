class CreateStudentTypes < ActiveRecord::Migration
  def change
    create_table :student_types do |t|
      t.references :student,      null: false, index: true
      t.string     :position,     null: false, index: true
      t.boolean    :manually_set, null: false, default: false

      t.timestamps null: false
    end
  end
end
