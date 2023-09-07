class AddSlugToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :slug, :string
    add_index :reservations, :slug, unique: true
  end
end
