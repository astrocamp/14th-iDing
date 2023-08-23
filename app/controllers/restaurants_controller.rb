# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show]

  def show
    @open_time = @restaurant.open_times.order(start_time: :asc)
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
