class Public::ItemsController < ApplicationController
  #ユーザーのログイン状態を確かめる。index,showはログインしてなくても閲覧可能にしてます。
  before_action :authenticate_customer!, only: [:create]
  def index
    @items = Item.all
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
  end

  def create
    @item = Item.new(items_params)
    @item.customer_id = current_customer.id
    
    byebug
    
    # @item.customer_id = current_customer.id
    @item.save!
    redirect_to action: 'index'

    # if @item.save
    #   redirect_to item_path(@item.id), notice:"新規投稿しました"
    # else
    #   @items = Item.all
    #   render :index
    # end

    # if @item.save
    #   redirect_back(fallback_location: root_path)  #コメント送信後は、一つ前のページへリダイレクトさせる。
    # else
    #   redirect_back(fallback_location: root_path)  #同上
    # end
  end

  def updated
    @item = Item.find(params[:id])
    if @item.update(items_params)
    redirect_to item_path(@item), notice:"Item was successfully updated."
    else
    render:edit
    end
  end

  def search
    if params[:keyword].present?
      # @genres = Genre.where('name LIKE ?', "%#{params[:keyword]}%")
      @items = Item.joins(:genres).where('genres.name LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @items = Item.all
    end
  end

  def destroy
    @item = Item.find(params[:id])
    current_customer.comments.find(params[:id]).destroy!
    flash[:notice] = 'コメントを削除しました'
    redirect_to item_path(@item)
  end

  private
  def items_params
    params.require(:item).permit(:image, :name, :introduction, :is_active, :genre_id)
  end
end
