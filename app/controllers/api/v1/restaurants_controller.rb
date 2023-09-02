# frozen_string_literal: true

module Api
  module V1
    class RestaurantsController < ApplicationController
      before_action :authenticate_user!

      def reservations
        restaurant = current_user.restaurants.find(params[:id])
        @reservations = restaurant.reservations.where(date: params[:start]..params[:end])
      end
    end
  end
end
