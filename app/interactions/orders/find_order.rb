class FindOrder < ActiveInteraction::Base
  string :id

  validates :id, presence: true

  def execute
    order = Order.find_by_id(id)

    order || errors.add(:base, I18n.t('orders.show.not_found'))
  end
end
