FactoryBot.define do
  factory :order do
    status { Order.statuses.keys.first }
    fulfiller { create(:fulfillment_center) }
  end
end
