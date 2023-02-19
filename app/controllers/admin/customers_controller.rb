class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  private
  def customers_params
    params.require(:customer).permit(:name, :email, :password, :is_deleted)
  end
end
