class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :product_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
