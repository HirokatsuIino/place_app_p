class CreateYomiko < ActiveRecord::Migration
  def change
    create_table :yomikos do |t|
        t.references :student, index: true
        t.references :teacher, index: true
        t.text       :challenge
        t.text       :yomiko
        t.text       :second_choice
        t.text       :condition

        t.timestamps null: false
    end
  end
end
