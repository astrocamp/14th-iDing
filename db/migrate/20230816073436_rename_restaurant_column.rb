class RenameRestaurantColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :restaurants, :english_name, :URL
  end
end
