class RemoveColumnsFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :username
    remove_column :users, :strava_id
    remove_column :users, :nike_id
    remove_column :users, :power_id
  end
end
