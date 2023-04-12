class Public::ItemsController < ApplicationController
  #ユーザーのログイン状態を確かめる。index,showはログインしてなくても閲覧可能にしてます。
  before_action :authenticate_customer!, only: [:create, :edit]
  before_action :correct_item,only: [:edit]
  def index
    @items = Item.all.page(params[:page]).per(10)
  end

  def show
    @item = Item.find(params[:id])
    @comments = @item.comments  #投稿詳細に関連付けてあるコメントを全取得
    if current_customer.present?
      @comment = current_customer.comments.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
    end
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def create
    @item = Item.new(items_params)
    @item.customer_id = current_customer.id
    @item.save
    redirect_to action: 'index'
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(items_params)
    redirect_to item_path(@item), notice:"投稿を編集しました"
    else
    render:edit
    end
  end

  def search
    if params[:keyword].present?
      # @genres = Genre.where('name LIKE ?', "%#{params[:keyword]}%")
      @items = Item.joins(:genres).where('genres.name LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    elsif params[:genre_id].present?
      @items = Item.where(genre_id: params[:genre_id])
      @keyword = Genre.find(params[:genre_id]).name
    else
      @items = Item.all
    end
  end

  def destroy
    @item = Item.find(params[:id])
    current_customer.items.find(params[:id]).destroy!
    flash[:notice] = '投稿を削除しました'
    redirect_to items_path
  end

  private

  def correct_item
    @item = Item.find(params[:id])
    unless @item.customer.id == current_customer.id
      redirect_to root_path  #直打ちした時リダイレクトするパスを指定
    end
  end

  def items_params
    params.require(:item).permit(:image, :name, :introduction, :is_active, :genre_id)
  end
end
