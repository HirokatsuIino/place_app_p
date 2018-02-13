class AddEmploymentConditionColumnToUser < ActiveRecord::Migration
  def change
    # 先生種別 ['Standard', 'Pro']
    add_column :users, :employment_type,   :string

    # 先生状態 ['Training', 'Normal']
    add_column :users, :employment_state,  :string
  end
end
