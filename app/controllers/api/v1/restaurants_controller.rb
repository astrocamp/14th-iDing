class Api::V1::RestaurantsController < ApplicationController
  before_action :authenticate_user!

  def reservations
    restaurant = current_user.restaurants.find(params[:id])
    @reservations = restaurant.reservations.where(date: params[:start]..params[:end])
  end
end
