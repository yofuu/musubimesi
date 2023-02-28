class Admin::GenresController < ApplicationController
  def new
    @genre = Genre.new
  end

  def create
     @genre = Genre.new(genres_params)

    if @genre.save
      redirect_to genre_path(@gemre.id), notice:"新しいジャンルを追加しました"
    else
      @genres = Genre.all
      render :index
    end
  end

  # ストロングパラメーター持ってくる
  private
  def genres_params
    params.require(:genre).permit(:name)
  end
end