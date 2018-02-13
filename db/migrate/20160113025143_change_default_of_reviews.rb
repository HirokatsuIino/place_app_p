class ChangeDefaultOfReviews < ActiveRecord::Migration
  def up
    change_column_default :teacher_reviews, :rate1, nil
    change_column_default :teacher_reviews, :rate2, nil
    change_column_default :teacher_reviews, :rate3, nil
    change_column_default :teacher_reviews, :rate4, nil
    change_column_default :teacher_reviews, :rate5, nil
  end

  def down
    change_column_default :teacher_reviews, :rate1, 0
    change_column_default :teacher_reviews, :rate2, 0
    change_column_default :teacher_reviews, :rate3, 0
    change_column_default :teacher_reviews, :rate4, 0
    change_column_default :teacher_reviews, :rate5, 0
  end
end
