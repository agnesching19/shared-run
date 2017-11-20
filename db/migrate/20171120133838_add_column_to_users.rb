class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :photo, :string
    add_column :users, :sociability, :integer
    add_column :users, :location, :string
    add_column :users, :pace, :time
    add_column :users, :schedule, :string
  end
end
