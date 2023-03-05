class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to admin_items_path
  end

  private
  def items_params
    params.require(:item).permit(:image, :name, :introduction, :customer_id, :is_active)
  end
end
