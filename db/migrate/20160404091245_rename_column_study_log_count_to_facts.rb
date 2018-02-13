class RenameColumnStudyLogCountToFacts < ActiveRecord::Migration
  def change
    rename_column :facts, :studylog_count, :good_studylog_count
  end
end
