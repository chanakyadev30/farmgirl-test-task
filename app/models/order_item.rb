class OrderItem < ApplicationRecord
  # associations
  belongs_to :order
  belongs_to :product

  # contants
  MIN_QUANTITY = 1
  MAX_QUANTITY = 10

  # validations
  validates :product_id, uniqueness: { scope: :order_id }
  validates :quantity, numericality: {
    only_integer: true,
    greater_than_or_equal_to: MIN_QUANTITY,
    less_than_or_equal_to: MAX_QUANTITY
  }
end
