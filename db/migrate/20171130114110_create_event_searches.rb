class CreateEventSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :event_searches do |t|
      t.references :user, foreign_key: true
      t.string :location
      t.float :latitude
      t.float :longitude
      t.float :proximity, default: 10.0
      t.date :run_date
      t.integer :run_distance
      t.timestamps
    end
  end
end
