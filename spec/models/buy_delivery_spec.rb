require 'rails_helper'

RSpec.describe BuyDelivery, type: :model do
  before do
    item = FactoryBot.create(:item)
    @buy_delivery = FactoryBot.build(:buy_delivery, user_id: item.user_id, item_id: item.id)
  end

  describe '商品購入' do
    context '正常に購入できる場合' do
      it '必須項目に全て入力' do
        expect(@buy_delivery).to be_valid
      end
      it '建物名が空でも購入できる' do
        @buy_delivery.building = ''
        expect(@buy_delivery).to be_valid
      end
    end

    context '正常に購入できない場合' do
      it 'トークンが空だと購入できない' do
        @buy_delivery.token = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空だと購入できない' do
        @buy_delivery.postal_code = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Postal code can't be blank")
      end
      it '都道府県が空だと購入できない' do
        @buy_delivery.prefecture = nil
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市町村が空だと購入できない' do
        @buy_delivery.city = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと購入できない' do
        @buy_delivery.addresses = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Addresses can't be blank")
      end
      it '電話番号が空だと購入できない' do
        @buy_delivery.phone_number = ''
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include("Phone number can't be blank")
      end
      it '郵便番号のフォーマットが合っていないと購入できない' do
        @buy_delivery.postal_code = '6012333'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it '電話番号のフォーマットが合っていないと購入できない' do
        @buy_delivery.phone_number = '080-9999-9999'
        @buy_delivery.valid?
        expect(@buy_delivery.errors.full_messages).to include('Phone number is invalid. Phone number must be between 10 and 11 digits')
      end
    end
  end
end
