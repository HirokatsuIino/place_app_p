class AddUniqueSenpreIdToUsers < ActiveRecord::Migration
  def up
       change_column :users, :senpre_id, :string, null: false, default: "", unique:true
  end

  def down
       change_column :users, :senpre_id, :string, null: false, default: ""
  end
end