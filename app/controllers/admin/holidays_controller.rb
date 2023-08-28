# frozen_string_literal: true

module Admin
  class HolidaysController < Admin::BaseController
    before_action :set_restaurant, only: %i[create]
    before_action :set_holiday, only: %i[destroy]

    def create
      @holiday = @restaurant.holidays.new(holiday_params)
      if @holiday.save
        redirect_to admin_restaurant_open_times_path(@holiday.restaurant), notice: '已新增公休日'
      else
        redirect_to admin_restaurant_open_times_path(@restaurant), alert: '該公休日已被選擇'
      end
    end

    def destroy
      @holiday.destroy
      redirect_to admin_restaurant_open_times_path(@holiday.restaurant), notice: '已刪除公休日'
    end

    private

    def holiday_params
      params.required(:holiday).permit(:dayoff)
    end

    def set_restaurant
      @restaurant = current_user.restaurants.find(params[:restaurant_id])
    end

    def set_holiday
      # 路徑已使用shallow, 不能用@holiday = @restaurant.holidays.find(params[:id]) => 等安裝frendily_id
      @holiday = Holiday.find(params[:id])
    end
  end
end
