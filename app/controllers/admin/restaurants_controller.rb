# frozen_string_literal: true

module Admin
  class RestaurantsController < Admin::BaseController
    before_action :set_restaurant, only: %i[show edit update destroy]

    def index
      @restaurants = current_user.restaurants.order(:id)
    end

    def show
      current_time = Time.now.in_time_zone('Taipei')

      @reservations = @restaurant.reservations.where("date > ? OR (date = ? AND time >= ?)", current_time.to_date, current_time.to_date, current_time.strftime("%H:%M:%S")).order(:date, :time)
      @reservation = @restaurant.reservations.new
    end

    def new
      @restaurant = current_user.restaurants.new
    end

    def create
      @restaurant = current_user.restaurants.new(restaurant_params)
      if @restaurant.save
        redirect_to admin_restaurants_path, notice: '餐廳新增成功'
      else
        flash[:alert] = '姓名、統編、地址、電話 <br> 不得空白'
        render :new
      end
    end

    def edit; end

    def update
      if @restaurant.update(restaurant_params)
        redirect_to admin_restaurants_path, notice: '餐廳資訊已更新'
      else
        render :edit
      end
    end

    def destroy
      @restaurant.destroy
      redirect_to admin_restaurants_path, notice: '餐廳刪除成功'
    end

    private

    def restaurant_params
      params.require(:restaurant)
            .permit(:name, :URL, :tel, :address, :description, :UBN, :image)
    end

    def set_restaurant
      @restaurant = current_user.restaurants.find(params[:id])
    end
  end
end
