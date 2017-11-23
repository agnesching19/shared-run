class AddTitleToRuns < ActiveRecord::Migration[5.1]
  def change
    add_column :runs, :title, :string
  end
end
