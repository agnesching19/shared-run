class CreateEventSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :event_searches do |t|
      t.references :user, foreign_key: true
      t.string :location
      t.float :proximity, default: 10.0
      t.integer :run_distance
      t.date :run_date
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
