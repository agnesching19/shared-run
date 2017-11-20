class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.date :date
      t.time :time
      t.string :location
      t.text :description
      t.integer :distance
      t.integer :price
      t.string :surface
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
