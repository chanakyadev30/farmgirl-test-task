class CreateOrder < ActiveInteraction::Base
  # passing order object due to nested params
  object :order

  validates :order, presence: true

  def to_model
    Order.new
  end

  def execute
    errors.merge!(order.errors) unless order.save

    order
  end
end
