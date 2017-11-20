class CreatePreferences < ActiveRecord::Migration[5.1]
  def change
    create_table :preferences do |t|
      t.time :time
      t.date :date
      t.string :location
      t.integer :sociability
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
