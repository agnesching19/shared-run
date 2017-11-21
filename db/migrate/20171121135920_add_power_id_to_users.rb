class AddPowerIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :power_id, :string
    add_index :users, :power_id, unique: true
  end
end
