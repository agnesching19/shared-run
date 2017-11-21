class AddTimeToSearch < ActiveRecord::Migration[5.1]
  def change
    add_column :searches, :run_time, :time
  end
end
