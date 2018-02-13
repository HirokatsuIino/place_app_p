class RenameLessonDatimeColumnToProcessedTime < ActiveRecord::Migration
  def change
    rename_column :transaction_records, :lesson_datetime, :processed_time
  end
end
