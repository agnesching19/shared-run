class AddSociabilityDistancePaceToSearches < ActiveRecord::Migration[5.1]
  def change
     add_column :searches, :sociability, :integer
     add_column :searches, :run_distance, :integer
     add_column :searches, :pace, :time
  end
end
