class CreateKakomonLog < ActiveRecord::Migration
  def change
    create_table :kakomon_logs do |t|
      t.references :student, index: true
      t.integer :year
      t.integer :month
      t.integer :day
      t.text    :college
      t.text    :questions_year
      t.text    :subject
      t.text    :correct
      t.text    :point
      t.text    :big_questions_correct
      t.text    :impression
      t.boolean :carried_out, default: false
      
      t.datetime :read_at
      t.datetime :deleted_at
      t.timestamps null: false
    end
  end
end
