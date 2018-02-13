class CreateStudentProfiles < ActiveRecord::Migration
  def change
    create_table :student_profiles do |t|
      t.references :student,  index: true
      t.text :content, null: false, default: "学習プロフィールを作成しました"
      t.text :free_content, null: false, default: ""

      t.timestamps null: false
    end
  end
end
