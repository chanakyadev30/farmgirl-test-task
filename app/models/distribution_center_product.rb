class DistributionCenterProduct < ApplicationRecord
  # associations
  belongs_to :distribution_center
  belongs_to :product

  # scope
  scope :with_products, ->(product_ids) { where(product_id: product_ids) }

  # validations
  validates :product_id, uniqueness: { scope: :distribution_center_id }
end
