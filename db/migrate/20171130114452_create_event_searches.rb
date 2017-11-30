class CreateEventSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :event_searches do |t|

      t.timestamps
    end
  end
end
