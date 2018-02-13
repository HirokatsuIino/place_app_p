class AddTrialColumnToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :trial_ticket, :boolean, null: false, default: false
  end
end
