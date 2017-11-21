class AddDateToSearch < ActiveRecord::Migration[5.1]
  def change
     add_column :searches, :run_date, :date
  end
end
