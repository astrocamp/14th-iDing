class AddDeletedAtToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :deleted_at, :datetime
    add_index :reservations, :deleted_at
  end
end
