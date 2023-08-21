class AddColumnToRestaurant < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :reserve_interval, :integer, default: 15
    add_column :restaurants, :mealtime, :integer, default: 60
    add_column :restaurants, :bookday_advance, :integer, default: 14
  end
end
