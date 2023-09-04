# frozen_string_literal: true

module Admin
  class TablesController < Admin::BaseController
    before_action :set_table, only: %i[edit update destroy]
    before_action :set_restaurant, only: %i[index new create tablemap]

    def index
      authorize(table)
      @tables = @restaurant.tables.order(:id)
    end

    def show
      authorize(table)
    end

    def new
      authorize(table)
      @table = @restaurant.tables.new
    end

    def create
      authorize(table)
      @table = @restaurant.tables.new(table_params)

      if @table.save
        redirect_to admin_restaurant_tables_path, notice: '桌子建立成功'
      else
        flash[:alert] = '桌號不得重複或空白'
        render :new
      end
    end

    def edit
      authorize(table)
    end

    def update
      authorize(table)
      if @table.update(table_params)
        redirect_to admin_restaurant_tables_path(@restaurant), notice: '桌子已更新'
      else
        render :edit
      end
    end

    def destroy
      authorize(table)
      @table.destroy
      redirect_to admin_restaurant_tables_path, notice: '桌子刪除成功'
    end

    def tablemap
      @tables = @restaurant.tables
    end

    private

    def table_params
      params.require(:table).permit(:name, :seat_num, :category)
    end

    def set_table
      set_restaurant
      @table = @restaurant.tables.find(params[:id])
    end

    def set_restaurant
      @restaurant = current_user.restaurants.find(params[:restaurant_id])
    end
  end
end
