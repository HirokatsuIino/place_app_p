class AddSomeStudyLogCountsColumnToFacts < ActiveRecord::Migration
  def change
    add_column :facts, :ok_studylog_count,  :integer, default: 0
    add_column :facts, :bad_studylog_count, :integer, default: 0
  end
end
