class AddProfilesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :nike, :string
    add_column :users, :strava, :string
    add_column :users, :power, :string
  end
end
