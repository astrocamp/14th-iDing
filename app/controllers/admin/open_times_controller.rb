# frozen_string_literal: true

module Admin
  class OpenTimesController < Admin::BaseController
    before_action :set_restaurant, only: %i[create index]
    before_action :set_open_time, only: %i[edit update destroy]

    def index
      @open_time = OpenTime.new
      # @open_times = @restaurant.open_times.includes(:restaurant).order(:start_time)
      @open_times = @restaurant.open_times.includes(:restaurant).order(Arel.sql("start_time AT TIME ZONE 'Asia/Taipei'"))

      @holidays = @restaurant.holidays.includes(:restaurant)
      @holiday = Holiday.new
      @week = (Date.today.beginning_of_week..Date.today.end_of_week)
    end

    def create
      @open_time = @restaurant.open_times.new(opentime_params)
      return unless @open_time.save

      redirect_to admin_restaurant_open_times_path(@open_time.restaurant), notice: '已建立時段'
    end

    def edit
      authorize :OpenTime
    end

    def update
      authorize :OpenTime
      return unless @open_time.update(opentime_params)

      redirect_to admin_restaurant_open_times_path(@open_time.restaurant), notice: '已更新時段'
    end

    def destroy
      @open_time.destroy
      redirect_to admin_restaurant_open_times_path(@open_time.restaurant), notice: '已刪除時段'
    end

    private

    def opentime_params
      params.require(:open_time).permit(:start_time, :end_time)
    end

    def set_restaurant
      @restaurant = current_user.restaurants.friendly.find(params[:restaurant_id])
    end

    def set_open_time
      @open_time = OpenTime.find(params[:id])
    end
  end
end
