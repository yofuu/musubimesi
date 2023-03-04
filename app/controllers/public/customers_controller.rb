class Public::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @items = Item.all
  end

  def edit
    @customer = current_customer
  end

  def mypage
    @customer = current_customer
    @items = Item.all
  end

  def update
    @customer = current_customer
    if @customer.update(customers_params)
    redirect_to customers_mypage_path(current_customer), notice:"会員情報を更新しました"
    else
    render:edit
    end
  end

  def withdraw
    @customer = current_customer
    if @customer.update(is_deleted: true)
      reset_session
    redirect_to root_path, notice:"退会しました"
    end
  end

  def unsubscribe
  end

  private
  def customers_params
    params.require(:customer).permit(:name, :email, :password, :is_deleted)
  end
end
