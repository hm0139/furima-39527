class OrdersController < ApplicationController
  before_action :set_public_key, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @order = Buy.new
  end

  def create
  end

  def set_public_key
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end
end
