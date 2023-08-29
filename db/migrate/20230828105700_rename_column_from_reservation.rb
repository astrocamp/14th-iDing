class RenameColumnFromReservation < ActiveRecord::Migration[7.0]
  def change
    rename_column :reservations, :adults, :adults
    rename_column :reservations, :kids, :kids
  end
end
