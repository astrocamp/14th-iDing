
module Admin
  class HolidaysController < ApplicationController
    before_action :find_restaurant, only: %i[create]
    before_action :find_holiday, only: %i[destroy]

    def create
      @holiday = @restaurant.holidays.new(holiday_params)
      if @holiday.save
        redirect_to admin_restaurant_open_times_path(@holiday.restaurant_id), notice: '已新增公休日'
      else
        redirect_to admin_restaurant_open_times_path(@restaurant), notice: '錯誤'
      end
    end

    def destroy
      @holiday.destroy
      redirect_to admin_restaurant_open_times_path(@holiday.restaurant_id), notice: '已刪除公休日'
    end


    private

    def holiday_params
      params.required(:holiday).permit(:dayoff)
    end

    def find_restaurant
      @restaurant = current_user.restaurants.find(params[:restaurant_id])
    end

    def find_holiday
      @holiday = Holiday.find(params[:id])
    end


  end

end
