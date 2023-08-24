# frozen_string_literal: true

module Admin
  class OpenTimesController < ApplicationController
    before_action :set_restaurant, only: %i[create index]
    before_action :set_open_time, only: %i[edit update destroy]

    def index
      @open_time = OpenTime.new
      @open_times = @restaurant.open_times.includes(:restaurant).order(start_time: :asc)
    end

    def create
      @open_time = @restaurant.open_times.new(opentime_params)
      @open_time.save
    end

    def edit
      render layout: 'application'
    end

    def update
      return unless @open_time.update(opentime_params)

      redirect_to admin_restaurant_open_times_path(@open_time.restaurant), notice: '已更新時段'
    end

    def destroy
      @open_time.destroy
    end

    private

    def opentime_params
      params.require(:open_time).permit(:start_time, :end_time)
    end

    def set_restaurant
      @restaurant = current_user.restaurants.find(params[:restaurant_id])
    end

    def set_open_time
      @open_time = OpenTime.find(params[:id])
    end
  end
end
