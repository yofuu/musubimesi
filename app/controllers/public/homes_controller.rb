class Public::HomesController < ApplicationController
  def top
    @items = Item.all
    # @all_ranks = Item.find(Like.group(:item_id).order('count(item_id) desc').limit(10).pluck(:item_id))
  end
end
