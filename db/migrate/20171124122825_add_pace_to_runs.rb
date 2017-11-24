class AddPaceToRuns < ActiveRecord::Migration[5.1]
  def change
    add_column :runs, :pace, :time
  end
end
