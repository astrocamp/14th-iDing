# frozen_string_literal: true

module Admin
  class ReservationsController < ApplicationController
    before_action :set_restaurant
    before_action :set_reservation, only: %i[edit update destroy]

    def search
      @search = Reservation.ransack(params[:q])
      @reservations = @search.result
    end

    def calendar; end

    def create
      @reservation = @restaurant.reservations.new(reservation_params)

      if @reservation.save
        redirect_to admin_restaurant_path(@restaurant), notice: '訂位新增成功'
        SendSmsJob.perform_later(@reservation)
      else
        redirect_to admin_restaurant_path(@restaurant), alert: '訂位失敗'
      end
    end

    def edit; end

    def update
      if @reservation.update(reservation_params)
        redirect_to admin_restaurant_path(@restaurant), notice: '訂位資訊已更新'
      else
        redirect_to admin_restaurant_path(@restaurant), alert: '訂位人數超過所選座位 / 目前已客滿'
      end
    end

    def destroy
      @reservation.cancel! if @reservation.may_cancel?
      @reservation.destroy
      redirect_to admin_restaurant_path(@restaurant), notice: '訂位刪除成功'
    end

    private

    def reservation_params
      params.require(:reservation)
            .permit(:name, :tel, :email, :gender, :date, :time, :adults, :kids, :purpose, :note, :serial, :table_id, :state)
    end

    def set_restaurant
      @restaurant = current_user.restaurants.find(params[:restaurant_id])
    end

    def set_reservation
      @reservation = @restaurant.reservations.find(params[:id])
    end
  end
end
