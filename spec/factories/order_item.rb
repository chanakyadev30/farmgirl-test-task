FactoryBot.define do
  factory :order_item do
    quantity { Faker::Number.between(from: OrderItem::MIN_QUANTITY, to: OrderItem::MAX_QUANTITY) }
    order
    product
  end
end
