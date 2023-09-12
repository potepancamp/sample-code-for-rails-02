class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :content
      t.string :address
      t.integer :price

      t.timestamps
    end
  end
end