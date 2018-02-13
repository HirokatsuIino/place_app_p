class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.text :line_id, null: false, defulat: ''

      t.timestamps null: false
    end
  end
end
