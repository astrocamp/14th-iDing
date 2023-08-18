class Admin::TablesController < ApplicationController

  before_action :set_table, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    # @tables = current_user.restaurants.tables.order(id: :asc)
    @tables = Table.includes(restaurant: :user).where(users: { id: current_user.id }).order(id: :asc)

  end

  def show
  end

  def new
    @restaurant = current_user.restaurants.find(params[:restaurant_id])
    @table = @restaurant.tables.new
  end

  def create
    @restaurant = current_user.restaurants.find(params[:restaurant_id])
    @table = @restaurant.tables.new(table_params)
    
    if @table.save
      redirect_to admin_restaurant_tables_path, notice: "桌子建立成功"
    else
      render :new
    end
  end

  def edit
    @restaurant = @table.restaurant
  end

  def update
    if @table.update(table_params)
        redirect_to admin_restaurant_tables_path(@restaurant), notice: "桌子已更新"
    else
        render :edit
    end
  end

  def destroy
    @table.destroy
      redirect_to admin_restaurant_tables_path, notice:'刪除成功'
  end

  private

  def table_params
    params.require(:table).permit(:name,:seat_num,:category)
  end

  def set_table
    @restaurant = current_user.restaurants.find(params[:restaurant_id])
    @table = @restaurant.tables.find(params[:id])
  end
  
end
