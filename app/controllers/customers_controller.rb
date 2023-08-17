# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :destroy]
  
  def index 
    @customers = Customer.order(id: :desc)
  end

  def new
    @customer = Customer.new
    @customer.reservations.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save # 同時保存客戶和預訂記錄
      redirect_to customer_path(@customer), notice: "訂位新增成功"
    else
      render :new
    end
  end

  def show; end

  def destroy 
    @customer.destroy
    redirect_to customers_path, notice: '訂位刪除成功'
  end

  private
    def customer_params
    params.require(:customer).permit( :name, :tel, :email, :gender, reservations_attributes: [ :adult_num, :kid_num, :date, :time, :purpose, :note, :_destroy])
    end

  def customer_params
    params.require(:customer).permit(:name, :tel, :email, :gender)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
