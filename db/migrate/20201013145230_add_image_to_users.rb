class AddImageToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :introduction, :text
    add_column :users, :image, :string
  end
end
