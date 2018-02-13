class CreateTeacherSettingTargets < ActiveRecord::Migration
  def change
    create_table :teacher_setting_targets do |t|
      t.integer :student_grade, null: false, default: 0
      t.integer :exam_type, null: false, default: 0
      t.references :teacher_setting, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
