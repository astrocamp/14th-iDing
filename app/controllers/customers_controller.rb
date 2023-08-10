class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  
  
  def index 
    @customers = Customer.order(id: :desc)
  end

  def new 
    @customer = Customer.new
  end

  def create 
    @customer = Customer.new(customer_params)
    if @customer.save 
      redirect_to customers_path, notice: "訂位新增成功"
    else
      render :new 
    end
  end

  def show
  end

  def edit 
  end


  def update 
    if @customer.update(customer_params)
      redirect_to customer_path, notice: "更新成功"
    else
      render :edit
    end
  end


  def destroy 
    @customer.destroy
    redirect_to customer_path, notice: '刪除成功'
  end



  private
    def customer_params 
      params.require(:customer).permit(:name, :tel, :email, :date, :time, :purpose, :note)
    end

    def set_customer
      @customer = Customer.find(params[:id])
    end
end
