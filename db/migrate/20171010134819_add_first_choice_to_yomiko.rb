class AddFirstChoiceToYomiko < ActiveRecord::Migration
  def change
    add_column :yomikos, :first_choice, :text
    add_column :yomikos, :memo, :text
  end
end
