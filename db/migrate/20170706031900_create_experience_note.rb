class CreateExperienceNote < ActiveRecord::Migration
  def change
    create_table :experience_notes do |t|
      t.references :user
      t.integer  :period
      t.text     :situation
      t.text     :reason
      t.text     :change
      t.text     :ambition
      t.datetime :published_at

      t.timestamps null: false
    end
  end
end
