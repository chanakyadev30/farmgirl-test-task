class Order < ApplicationRecord
  # associations
  belongs_to :fulfiller, polymorphic: true

  # constants
  enum status: %i[not_fulfilled fulfilled]

  # validations
  validates :status, inclusion: { in: statuses.keys }
end
