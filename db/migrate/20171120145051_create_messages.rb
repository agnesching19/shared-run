class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :run, foreign_key: true
      t.references :user

      t.timestamps
    end
  end
end
