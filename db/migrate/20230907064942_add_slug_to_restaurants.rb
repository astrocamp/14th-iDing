class AddSlugToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :slug, :string
    add_index :restaurants, :slug, unique: true
  end
end
