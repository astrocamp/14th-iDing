class Admin::OpenTimesController < ApplicationController
  before_action :find_restaurant, only: %i[create index]
  before_action :find_open_time, only: %i[edit update destroy]



  def index 
    @open_time = OpenTime.new
    @open_times = @restaurant.open_times.includes(:restaurant)
  end


  def create
    start_time = Time.new(  
      params[:open_time]['start_time(1i)'].to_i,
      params[:open_time]['start_time(2i)'].to_i,
      params[:open_time]['start_time(3i)'].to_i,
      params[:open_time]['start_time(4i)'].to_i,
      params[:open_time]['start_time(5i)'].to_i
    )
    close_time = Time.new(
      params[:open_time]['close_time(1i)'].to_i,
      params[:open_time]['close_time(2i)'].to_i,
      params[:open_time]['close_time(3i)'].to_i,
      params[:open_time]['close_time(4i)'].to_i,
      params[:open_time]['close_time(5i)'].to_i
    )

    if start_time < close_time
      @start_time = @restaurant.open_times.new(opentime_params)
      @start_time.save
    end
  end

  def edit
    render layout: 'application'
  end

  def update
    return unless @open_time.update(opentime_params)

    redirect_to admin_restaurant_open_times_path(@open_time.restaurant), notice: '已更新時段'
  end

  def destroy
    @open_time.destroy
  end


  private

  def opentime_params
    params.require(:open_time).permit(:start_time, :close_time)
  end

  def find_restaurant
    @restaurant = current_user.restaurants.find(params[:restaurant_id])
  end

  # def build_time_from_params(time_input)
  #   # Time.new(
  #   #   params[:open_time]["#{time_input}(1i)"].to_i,
  #   #   params[:open_time]["#{time_input}(2i)"].to_i,
  #   #   params[:open_time]["#{time_input}(3i)"].to_i,
  #   #   params[:open_time]["#{time_input}(4i)"].to_i,
  #   #   params[:open_time]["#{time_input}(5i)"].to_i
  #   # )
  # end
  def find_open_time
    @open_time = OpenTime.find(params[:id])
  end
end
