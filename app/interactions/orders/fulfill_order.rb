class FulfillOrder < ActiveInteraction::Base
  object :order

  validates :order, presence: true

  def execute
    errors.add(:base, I18n.t('orders.fulfill.already_fulfilled')) if order.fulfilled?
    errors.add(:base, I18n.t('orders.fulfill.error')) unless order.fulfilled!
    errors.merge!(order.errors) if errors.any?
    order
  end
end
