class AddRevieverToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :reviewer_id, :integer
    add_index :reviews, :reviewer_id
  end
end
