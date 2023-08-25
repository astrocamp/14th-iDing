# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show]
  before_action :set_holidays, only: %i[show]
  before_action :set_weekdays, only: %i[show]


  def index
    @restaurants = Restaurant.all
  end

  def show
    @open_time = @restaurant.open_times.order(start_time: :asc)
    #@chinese_weekdays = ["日", "一", "二", "三", "四", "五", "六"] 
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
  
  def set_holidays
    @holidays = @restaurant.holidays.map(&:dayoff)
  end

  def set_weekdays
    @chinese_weekdays = ["日", "一", "二", "三", "四", "五", "六"] 
  end

end
