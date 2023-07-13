class BuyDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :postal_code, :prefecture, :city, :addresses, :building, :phone_number, :buy_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture, numericality: {other_than: 0, message: "can't be blank"}
    validates :city
    validates :addresses
    validates :phone_number,
              format: { with: /\A[0-9]{10,11}\z/, message: 'is invalid. Phone number must be between 10 and 11 digits' }
  end

  def save
    buy = Buy.create(user_id:, item_id:)
    Delivery.create(post_code: postal_code, prefecture:, municipality: city, address: addresses,
                    building_name: building, telephone_number: phone_number, buy_id: buy.id)
  end
end
