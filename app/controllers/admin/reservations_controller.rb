# frozen_string_literal: true

module Admin
  class ReservationsController < ApplicationController
    before_action :set_restaurant
    before_action :set_reservation, only: %i[edit update destroy]

    def create
      @reservation = @restaurant.reservations.new(reservation_params)

      if total_guests_valid?
        @reservation.save
        redirect_to admin_restaurant_path(@restaurant), notice: '訂位新增成功'
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
      @reservation.destroy
      redirect_to admin_restaurant_path(@restaurant), notice: '訂位刪除成功'
    end

    private

    def reservation_params
      params.require(:reservation)
            .permit(:name, :tel, :email, :gender, :date, :time, :adult_num, :kid_num, :purpose, :note, :serial, :table_id)
    end

    def set_restaurant
      @restaurant = current_user.restaurants.find(params[:restaurant_id])
    end

    def set_reservation
      @reservation = @restaurant.reservations.find(params[:id])
    end
  
      
    def total_guests_valid?
      @total_guests = @reservation.adult_num + @reservation.kid_num
      vacant_table = @restaurant.tables.where(status: 'vacant').where('seat_num >= ?', @total_guests).first

      if vacant_table
        @reservation.table_id = vacant_table.id
        @reservation.save
      else
        false
      end
    end
  end
end
