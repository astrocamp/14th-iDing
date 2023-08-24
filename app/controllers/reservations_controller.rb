# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[destroy]

  def destroy
    @reservation.destroy
    redirect_to restaurants_path, notice: '訂位刪除成功'
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

end
