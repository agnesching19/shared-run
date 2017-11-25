class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.references :users, foreign_key: true
      t.references :runs, foreign_key: true
    end
  end
end
