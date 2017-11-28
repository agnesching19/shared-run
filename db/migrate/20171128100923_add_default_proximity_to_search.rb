class AddDefaultProximityToSearch < ActiveRecord::Migration[5.1]
  def change
    change_column :searches, :proximity, :float,  default: 3
  end
end
