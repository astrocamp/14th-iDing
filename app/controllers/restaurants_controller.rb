class RestaurantsController < ApplicationController
  before_action :find_user_restaurant, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @restaurants = current_user.restaurants.order(id: :desc)
  end

  def show
  end

  def new 
    @restaurant = current_user.restaurants.new
  end

  def create 
    @restaurant = current_user.restaurants.new(restaurant_params)
    if @restaurant.save 
      redirect_to restaurants_path, notice: "餐廳新增成功"
    else
      render :new 
    end
  end

  def edit 
  end

  def update 
    if @restaurant.update(restaurant_params)
      redirect_to restaurants_path, notice: "餐廳資訊已更新"
    else
      render :edit
    end
  end

  def destroy 
    @restaurant.destroy
    redirect_to restaurants_path, notice: '刪除成功'
  end


  private

  def restaurant_params
    params.require(:restaurant)
          .permit(:name, :english_name, :tel, :address, :description, :UBN, :image)
  end

  def find_user_restaurant
    @restaurant = current_user.restaurants.find(params[:id])
  end
end
