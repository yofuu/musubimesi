class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  def new
    @genre = Genre.new
  end

  def create
     @genre = Genre.new(genres_params)
    # @genre.customer_id = current_customer.id

    if @genre.save
      redirect_to admin_items_path, notice:"新しいジャンルを追加しました"
    else
      @genres = Genre.all
      render :new
    end
  end

  # ストロングパラメーター持ってくる
  private
  def genres_params
    params.require(:genre).permit(:name, :genre_id)
  end
end