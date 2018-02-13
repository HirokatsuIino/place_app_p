class CreateSupportSupporter < ActiveRecord::Migration
  def change
    create_table :support_supporters do |t|
      t.references :support_user
      t.references :supporter

      t.timestamps null: false
    end

    add_index       :support_supporters, [:support_user_id, :supporter_id], unique: true
    add_foreign_key :support_supporters, :users, column: :support_user_id
    add_foreign_key :support_supporters, :users, column: :supporter_id
  end
end
