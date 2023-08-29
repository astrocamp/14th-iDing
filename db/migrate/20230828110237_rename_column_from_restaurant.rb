class RenameColumnFromRestaurant < ActiveRecord::Migration[7.0]
  def change
    rename_column :restaurants, :URL, :url
    rename_column :restaurants, :UBN, :ubn
  end
end
