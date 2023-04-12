class Public::CommentsController < ApplicationController
  def create
    @comment = current_customer.comments.new(comment_params)
    if @comment.save
      redirect_back(fallback_location: root_path)  #コメント送信後は、一つ前のページへリダイレクトさせる。
    else
      redirect_back(fallback_location: root_path)  #同上
    end
  end

  def destroy
    @item = Item.find(params[:id])
    current_customer.comments.find(params[:item_id]).destroy
    flash[:notice] = 'コメントを削除しました'
    redirect_to item_path(@item)
  end

  private
  def comment_params
    params.require(:comment).permit(:item_id, :customer_id, :body)
  end
end
