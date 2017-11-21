class AddNikeIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :nike_id, :string
    add_index :users, :nike_id, unique: true
  end
end
