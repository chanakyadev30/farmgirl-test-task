class DistributionCenter < ApplicationRecord
  # associations
  has_many :orders, as: :fulfiller, dependent: :destroy
  has_many :products, through: :distribution_center_products # for future reference

  # validations
  validates :name, presence: true
end
