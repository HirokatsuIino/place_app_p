class CreateUserGroupAttributes < ActiveRecord::Migration
  def change
    create_table :user_group_attributes do |t|
      t.references :user_group, index: true
      t.text       :name,       null: false, default: ''
      t.text       :value,      null: false, default: ''

      t.timestamps null: false
    end
  end
end
