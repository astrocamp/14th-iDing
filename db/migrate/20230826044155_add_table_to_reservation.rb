class AddTableToReservation < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :reservations, :table, foreign_key: true
  end
end
