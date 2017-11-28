class RemoveRecipientFromReviews < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :reviewer_id
  end
end
