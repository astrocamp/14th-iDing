class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.order(date: :desc)
  end

  # def update_table_id(reservation)
  #   reservation.update_column(:table_id, reservation.restraurant.table) if reservation.restraurant.table.present?
  # end
end
