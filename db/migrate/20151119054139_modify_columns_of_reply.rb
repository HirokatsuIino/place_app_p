class ModifyColumnsOfReply < ActiveRecord::Migration
  def change
    add_reference :replies, :original_post, index: true
    add_reference :replies, :target_post,   index: true

    remove_column :replies, :target_user_id
  end
end
