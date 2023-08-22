class AddRestaurantIdToReservation < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservations, :restaurant_id
    add_belongs_to :reservations, :restaurant, index: true, null: false, foreign_key: true
  end
end
