FactoryBot.define do
  factory :buy_delivery do
    postal_code { '601-3205' }
    prefecture { 1 }
    city { '札幌市' }
    addresses { '札幌123' }
    building { '札幌ビル' }
    phone_number { Faker::Number.number(digits: 10) }
    token { 'ch_' + Faker::Lorem.characters(number: 29) }
    buy_id { 999 }
  end
end
