class EditRunDistanceColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :runs, :distance, :run_distance
  end
end
