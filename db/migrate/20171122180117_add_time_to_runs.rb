class AddTimeToRuns < ActiveRecord::Migration[5.1]
  def change
    add_column :runs, :time, :time
  end
end
