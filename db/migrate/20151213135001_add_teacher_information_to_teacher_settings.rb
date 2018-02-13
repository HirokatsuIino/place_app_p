class AddTeacherInformationToTeacherSettings < ActiveRecord::Migration
  def change
    change_table :teacher_settings do |t|
      t.string :wanted_student, null: false, default: ''
      t.string :p_hometown, null: false, default: ''
      t.string :p_hometown_comment, null: false, default: ''
      t.string :p_elementary_type, null: false, default: ''
      t.string :p_elementary_name, null: false, default: ''
      t.string :p_elementary_comment, null: false, default: ''
      t.string :p_junior_high_type, null: false, default: ''
      t.string :p_junior_high_name, null: false, default: ''
      t.string :p_junior_high_comment, null: false, default: ''
      t.string :p_high_school_type, null: false, default: ''
      t.string :p_high_school_name, null: false, default: ''
      t.string :p_high_school_comment, null: false, default: ''
      t.string :p_exam, null: false, default: ''
      t.string :p_exam_comment, null: false, default: ''
      t.string :p_education_department, null: false, default: ''
      t.string :p_education_comment, null: false, default: ''
      t.string :p_after_graduation, null: false, default: ''
      t.string :p_after_graduation_comment, null: false, default: ''
      t.string :p_now, null: false, default: ''
      t.string :p_now_comment, null: false, default: ''
      t.string :subject_1, null: false, default: "0"
      t.string :subject_2, null: false, default: "0"
      t.string :subject_3, null: false, default: "0"
      t.string :subject_4, null: false, default: "0"
      t.string :subject_5, null: false, default: "0"
      t.string :subject_6, null: false, default: "0"
      t.string :subject_7, null: false, default: "0"
      t.string :subject_8, null: false, default: "0"
      t.string :subject_9, null: false, default: "0"
      t.string :subject_10, null: false, default: "0"
      t.string :subject_11, null: false, default: "0"
      t.string :subject_12, null: false, default: "0"
      t.string :subject_13, null: false, default: "0"
      t.string :subject_14, null: false, default: "0"
      t.string :subject_15, null: false, default: "0"
      t.string :subject_16, null: false, default: "0"
      t.string :subject_17, null: false, default: "0"
      t.string :subject_18, null: false, default: "0"
      t.string :subject_19, null: false, default: "0"
      t.string :subject_20, null: false, default: "0"
      t.string :publish, null: false, default: "0"
    end
  end
end
