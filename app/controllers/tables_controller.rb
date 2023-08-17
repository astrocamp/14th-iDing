# frozen_string_literal: true

class TablesController < ApplicationController
  before_action :find_table, only: %i[show edit update destroy]

  def index
    @tables = Table.order(id: :asc)
  end

  def show; end

  def new
    @table = Table.new
  end

  def create
    @table = Table.new(table_params)
    if @table.save
      redirect_to tables_path, notice: '桌子建立成功'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @table.update(table_params)
      redirect_to tables_path, notice: '桌子已更新'
    else
      render :edit
    end
  end

  def destroy
    @table.destroy
    redirect_to tables_path, notice: '刪除成功'
  end

  private

  def table_params
    params.require(:table).permit(:name, :seat_num, :category)
  end

  def find_table
    @table = Table.find(params[:id])
  end
end
