class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
    @items = @customer.items
  end

  private
  def customers_params
    params.require(:customer).permit(:name, :email, :password, :is_deleted)
  end
end
