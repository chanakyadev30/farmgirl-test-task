class Product < ApplicationRecord
  # associations
  has_many :distribution_center, through: :distribution_center_products # for future reference

  # validations
  validates :name, presence: true, uniqueness: true
end
