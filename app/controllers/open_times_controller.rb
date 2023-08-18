class OpenTimesController < ApplicationController
  before_action :find_restaurant, only: %i[create index]
  before_action :find_opening_time, only: %i[edit update destroy]


  def create
    start_time = build_time_from_params('start_time')
    close_time = build_time_from_params('close_time')

    if start_time < close_time
      @start_time = @restaurant.opening_times.new(opentime_params)
      @start_time.save
    end
  end




  private

  def opentime_params
    params.require(:opening_time).permit(:start_time, :close_time)
  end

  def find_restaurant
    @restaurant = current_user.restaurants.find(params[:restaurant_id])
  end

  def build_time_from_params(time_input)
    Time.new(
      params[:opening_time]["#{time_input}(1i)"].to_i,
      params[:opening_time]["#{time_input}(2i)"].to_i,
      params[:opening_time]["#{time_input}(3i)"].to_i,
      params[:opening_time]["#{time_input}(4i)"].to_i,
      params[:opening_time]["#{time_input}(5i)"].to_i
    )
  end

end
