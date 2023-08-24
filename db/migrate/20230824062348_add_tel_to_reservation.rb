class AddTelToReservation < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :tel, :tring
  end
end
