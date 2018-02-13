class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.references :student,        null: false, index: true
      t.references :teacher,        null: false, index: true
      t.date       :date,           null: false
      t.integer    :studylog_count, default: 0
      t.integer    :weekrepo_count, default: 0
      t.integer    :like_count,     default: 0
      t.integer    :rt_count,       default: 0
      t.integer    :action_count,   default: 0

      t.timestamps null: false
    end
  end
end
