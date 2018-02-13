class CreateTeacherProfile < ActiveRecord::Migration
  def change
    create_table :teacher_profiles do |t|
      t.references :teacher,  index: true
      t.string     :university
      t.string     :department
      t.string     :grade
      t.string     :hometown
      t.text       :self_introduction
      t.text       :experience_exam
      t.string     :subject_exam
      t.string     :results_exam
      t.text       :comment_recommender    

      t.timestamps null: false
    end
  end
end