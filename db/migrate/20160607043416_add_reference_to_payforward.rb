class AddReferenceToPayforward < ActiveRecord::Migration
  def change
    add_reference :payforwards, :teacher_review, index: true
  end
end
