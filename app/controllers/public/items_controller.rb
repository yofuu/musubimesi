class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(items_params)

    if @item.save
      redirect_to item_path(@item.id), notice:"Item was successfully updated."
    else
      @items = Item.all
      render :index
    end
  end

  private
  def items_params
    params.require(:item).permit(:image, :name, :introduction, :customer_id, :is_active)
  end
end
