class Admin::TablesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_table, only: [:edit, :update, :destroy]
  before_action :set_restaurant, only: [:index, :new, :create]

  def index
    @tables = @restaurant.tables.order(id: :asc)
  end

  def new
    @table = @restaurant.tables.new
  end

  def create
    @table = @restaurant.tables.new(table_params)
    
    if @table.save
      redirect_to admin_restaurant_tables_path, notice: "桌子建立成功"
    else
      render :new
    end
  end

  def edit
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
    set_restaurant
    @table = @restaurant.tables.find(params[:id])
  end

  def set_restaurant
    @restaurant = current_user.restaurants.find(params[:restaurant_id])
  end
  
end
