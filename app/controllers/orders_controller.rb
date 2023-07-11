class OrdersController < ApplicationController
  before_action :set_public_key
  before_action :move_to_top
  before_action :item_find

  def index
    @buy_delivery = BuyDelivery.new
  end

  def create
    @buy_delivery = BuyDelivery.new(order_params)
    if @buy_delivery.valid?
      item = Item.find(@buy_delivery.item_id)
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      Payjp::Charge.create(
        amount: item.price, # 商品の値段
        card: params[:token], # カードトークン
        currency: 'jpy' # 通貨の種類（日本円）
      )
      @buy_delivery.save
      redirect_to root_path
    else
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:buy_delivery).permit(:postal_code, :prefecture, :city, :addresses, :building, :phone_number).merge(
      token: params[:token], user_id: current_user.id, item_id: params[:item_id]
    )
  end

  def set_public_key
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def move_to_top
    item = Item.find(params[:item_id])
    return unless !user_signed_in? || !item.buy.nil? || current_user.id == item.user.id

    redirect_to root_path
  end

  def item_find
    @item = Item.find(params[:item_id])
  end
end
