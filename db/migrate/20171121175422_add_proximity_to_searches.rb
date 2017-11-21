class AddProximityToSearches < ActiveRecord::Migration[5.1]
  def change
    add_column :searches, :proximity, :float
  end
end
