class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end
  
  def new
    @item = Item.new
  end
  
  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(items_params)
    @item.customer_id = current_customer.id

    if @item.save
      redirect_to item_path(@item.id), notice:"Item was successfully updated."
    else
      @items = Item.all
      render :index
    end
  end
  
  def updated
    @item = Item.find(params[:id])
    if @item.update(items_params)
    redirect_to item_path(@item), notice:"Item was successfully updated."
    else
    render:edit
    end
  end

  private
  def items_params
    params.require(:item).permit(:image, :name, :introduction, :is_active)
  end
end
