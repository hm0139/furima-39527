class Buy < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :delivery
  attr_accessor :token
end
