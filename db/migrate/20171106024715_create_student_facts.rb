class CreateStudentFacts < ActiveRecord::Migration
  def change
    create_table :student_facts do |t|
      t.references :student, index: true
      t.references :teacher
      t.references :supporter

      t.integer    :value_type, default: 0
      t.float      :numerator, default: 0.0
      t.float      :denominator, default: 0.0
      t.date       :start_date
      t.date       :end_date
    end

    add_foreign_key :student_facts, :users, column: :teacher_id
    add_foreign_key :student_facts, :users, column: :supporter_id
  end
end
