class RemoveColumnFromReservation < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservations, :phone
  end
end
