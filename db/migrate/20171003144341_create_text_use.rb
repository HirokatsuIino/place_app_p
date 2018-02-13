class CreateTextUse < ActiveRecord::Migration
  def change
    create_table :text_uses do |t|
      t.references :student, index: true
      t.text       :content

      t.timestamps null: false
    end
  end
end
