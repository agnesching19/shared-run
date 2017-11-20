class CreateRuns < ActiveRecord::Migration[5.1]
  def change
    create_table :runs do |t|
      t.references :user, foreign_key: true
      t.string :location
      t.date :date
      t.text :description
      t.integer :distance
      t.integer :capacity
      t.string :photo
      t.boolean :shared
      t.timestamps
    end
  end
end
