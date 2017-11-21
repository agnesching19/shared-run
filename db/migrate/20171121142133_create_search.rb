class CreateSearch < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.references :user, foreign_key: true
      t.string :location
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
