# frozen_string_literal: true

module Admin
  class RestaurantsController < Admin::BaseController
    before_action :set_restaurant, only: %i[show edit update destroy]

    def index
      @restaurants = current_user.restaurants
    end

    def show
      @reservations = if params[:date].present?
                        @restaurant.reservations.where(date: params[:date])
                      else
                        @restaurant.reservations.in_future(Time.current)
                      end

      @reservation = Reservation.new
    end

    def new
      @restaurant = Restaurant.new
    end

    def create
      @restaurant = current_user.restaurants.new(restaurant_params)
      if @restaurant.save
        redirect_to admin_restaurants_path, notice: '餐廳新增成功'
      else
        flash[:alert] = '必填欄位尚未填寫'
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
            .permit(:name, :url, :tel, :address, :description, :ubn, :image, :bookday_advance, :mealtime, :reserve_interval)
    end

    def set_restaurant
      @restaurant = current_user.restaurants.find(params[:id])
    end
  end
end
