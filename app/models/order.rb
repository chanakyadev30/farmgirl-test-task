class Order < ApplicationRecord
  # associations
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  belongs_to :fulfiller, polymorphic: true

  # constants
  enum status: %i[not_fulfilled fulfilled]

  # validations
  validates :status, inclusion: { in: statuses.keys }
end
