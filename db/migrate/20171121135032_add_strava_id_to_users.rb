class AddStravaIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :strava_id, :string
    add_index :users, :strava_id, unique: true
  end
end
