class ModifyColumnsOfRepost < ActiveRecord::Migration
  def change
    add_reference :reposts, :target_post, index: true
  end
end
