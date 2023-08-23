# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[edit update destroy]
  before_action :set_restaurant, only: %i[index new create]

  def index
    @reservations = @restaurant.reservations.order(date: :asc)
  end

  def show; end

  def new
    @reservation = @restaurant.reservations.new
  end

  def create
    @reservation = @restaurant.reservations.new(reservation_params)

    if @reservation.save
      redirect_to restaurant_reservations_path, notice: '訂位建立成功'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @reservation.update(reservation_params)
      redirect_to restaurant_reservations_path(@restaurant), notice: '訂位已更新'
    else
      render :edit
    end
  end

  def destroy
    @reservation.destroy
    redirect_to restaurant_reservations_path, notice: '訂位刪除成功'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:date, :time, :name, :phone, :email, :gender, :adult_num, :kid_num, :purpose, :note)
  end

  def set_reservation
    set_restaurant
    @reservation = @restaurant.reservations.find(params[:id])
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  # def update_table_id(reservation)
  #   reservation.update_column(:table_id, reservation.restraurant.table) if reservation.restraurant.table.present?
  # end
end
