class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show reserve occupied]

  def index
  end
  
  def show 
    @open_time = @restaurant.open_times.order(start_time: :asc)
  end

  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end


  private
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end



end
