class ChangeCulumnToUser < ActiveRecord::Migration
  def change
    change_column_null :users, :nickname,     :string, false
    change_column_null :users, :image_id,     :string, false
    change_column_null :users, :phone_number, :string, false

    change_column_default :users, :nickname, ''
    change_column_default :users, :image_id, ''
    change_column_default :users, :phone_number, ''
  end
end
