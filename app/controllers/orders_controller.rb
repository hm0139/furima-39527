class OrdersController < ApplicationController
  before_action :set_public_key, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @order = Buy.new
  end

  def create
    @order = Buy.new(order_params)
    if @order.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: params[:price],  # 商品の値段
        card: params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
      @order.save
      return redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:buy).permit(:price).merge(token: params[:token],user_id: current_user.id,item_id: params[:item_id])
  end

  def set_public_key
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end
end
