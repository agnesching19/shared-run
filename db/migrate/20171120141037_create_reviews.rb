class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :run, foreign_key: true
      t.boolean :punctuality
      t.timestamps
    end
  end
end
