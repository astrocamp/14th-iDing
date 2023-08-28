# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show]
  before_action :set_holidays, only: %i[show]

  def index
    @restaurants = Restaurant.order(:id)
  end

  def show
    @open_time = @restaurant.open_times.order(start_time: :asc)
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def set_holidays
    @holidays = @restaurant.holidays.where.not(dayoff: nil).pluck(:dayoff)
  end
end
