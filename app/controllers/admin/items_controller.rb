class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    current_customer.comments.find(params[:id]).destroy!
    flash[:notice] = 'コメントを削除しました'
    redirect_to admin_item_path(@item)
  end

  private
  def items_params
    params.require(:item).permit(:image, :name, :introduction, :customer_id, :is_active)
  end
end
