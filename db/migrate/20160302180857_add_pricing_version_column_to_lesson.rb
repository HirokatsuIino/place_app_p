class AddPricingVersionColumnToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :pricing_version, :string
  end
end
