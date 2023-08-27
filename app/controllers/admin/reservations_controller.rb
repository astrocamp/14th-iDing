# frozen_string_literal: true

module Admin
  class ReservationsController < ApplicationController
    before_action :set_restaurant

    def create
      @reservation = @restaurant.reservations.new(reservation_params)
      if @reservation.save
        redirect_to admin_restaurant_path(@restaurant), notice: '訂位新增成功'
      else
        flash[:alert] = '訂位失敗'
        redirect_to admin_restaurant_path(@restaurant)
      end
    end

    def destroy
      reservation = @restaurant.reservations.find(params[:id])
      reservation.destroy
      redirect_to admin_restaurant_path(@restaurant), notice: '訂位刪除成功'
    end

    private

    def reservation_params
      params.require(:reservation)
            .permit(:name, :tel, :email, :gender, :date, :time, :adult_num, :kid_num, :purpose, :note, :serial)
    end

    def set_restaurant
      @restaurant = current_user.restaurants.find(params[:restaurant_id])
    end
  end
end
