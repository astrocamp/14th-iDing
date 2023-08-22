class AddColumnToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :name, :string, null: false
    add_column :reservations, :phone, :string, null: false
    add_column :reservations, :email, :string
    add_column :reservations, :gender, :integer
  end
end
