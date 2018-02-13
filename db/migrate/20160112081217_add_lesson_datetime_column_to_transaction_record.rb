class AddLessonDatetimeColumnToTransactionRecord < ActiveRecord::Migration
  def change
    add_column :transaction_records, :lesson_datetime, :datetime
  end
end
