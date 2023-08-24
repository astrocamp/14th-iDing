class RemoveCustomerFromReservation < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservations, :customer_id
  end
end
