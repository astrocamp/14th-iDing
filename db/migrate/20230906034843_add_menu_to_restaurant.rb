class AddMenusToRestaurant < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :menus, :json
  end
end
