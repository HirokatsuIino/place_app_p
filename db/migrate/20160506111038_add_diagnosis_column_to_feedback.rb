class AddDiagnosisColumnToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :diagnosis, :integer, default: 0
  end
end
