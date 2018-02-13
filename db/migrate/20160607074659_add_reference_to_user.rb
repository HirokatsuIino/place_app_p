class AddReferenceToUser < ActiveRecord::Migration
  def change
    add_reference :users, :payforward_message, index: true
  end
end
