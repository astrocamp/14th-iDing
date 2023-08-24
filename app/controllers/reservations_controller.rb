# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[destroy]

  def destroy
    @reservation.destroy
    redirect_to restaurants_path, notice: '訂位刪除成功'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:date, :time, :name, :tel, :email, :gender, :adult_num, :kid_num, :purpose, :note, :serial)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end
