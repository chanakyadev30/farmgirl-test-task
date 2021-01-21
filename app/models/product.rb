class Product < ApplicationRecord
  # validations
  validates :name, presence: true, uniqueness: true
end
