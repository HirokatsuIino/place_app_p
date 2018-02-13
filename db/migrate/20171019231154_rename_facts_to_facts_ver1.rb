class RenameFactsToFactsVer1 < ActiveRecord::Migration
  def change
    rename_table :facts, :facts_ver_1
  end
end
