class EditDistanceinEvents < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :distance, :run_distance
  end
end
