class AddColumnToRestaurant < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :name, :string
    add_column :restaurants, :tel, :string
    add_column :restaurants, :address, :string
    add_column :restaurants, :description, :text
    add_column :restaurants, :image, :string
    add_column :restaurants, :close_weekday, :string
    add_column :restaurants, :open_hour, :string
    add_column :restaurants, :UBN, :string
  end
end
