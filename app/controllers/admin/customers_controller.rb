class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  private
  def items_params
    params.require(:item).permit(:name, :email, :password, :is_deleted)
  end
end
