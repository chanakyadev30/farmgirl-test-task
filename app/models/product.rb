class Product < ApplicationRecord
  # associations
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items # for future reference
  has_many :distribution_center, through: :distribution_center_products # for future reference

  # validations
  validates :name, presence: true, uniqueness: true
end
