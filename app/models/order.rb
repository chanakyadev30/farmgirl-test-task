class Order < ApplicationRecord
  # associations
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  belongs_to :fulfiller, polymorphic: true

  accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true

  # constants
  enum status: %i[not_fulfilled fulfilled]
  PER_PAGE = 10

  # scopes
  scope :by_recent,       -> { order(created_at: :desc) }
  scope :created_between, ->(start_date, end_date) { where(created_at: start_date..end_date) }

  # validations
  validates :status, inclusion: { in: statuses.keys }
  validate :uniqueness_of_products, on: :create

  # callbacks
  before_validation :set_fulfiller, on: :create

  # product in an order can't repeat
  def uniqueness_of_products
    return if order_items.length == order_items.map(&:product_id).uniq.length

    errors.add(:base, I18n.t('orders.create.duplicate_products'))
  end

  # add fulfiller for the order. Either distribution center or fulfillment center
  def set_fulfiller
    self.fulfiller = FulfillerService.call(self)
  end

  # if date passed, gives total quantity for the date otherwise overall quantity
  def self.total_quantity(date = nil)
    order = fetch_order_by_date(date)
    order.joins(:order_items).sum(:quantity)
  end

  # if date passed, gives average for the date otherwise overall average
  def self.total_average(date = nil)
    order = fetch_order_by_date(date)
    order.joins(:order_items).average(:quantity)
  end

  # distinct products names for a order
  def product_names
    products.map(&:name).uniq.join(', ')
  end

  # total quantity of a order
  def quantity
    order_items.sum(&:quantity)
  end

  class << self
    private

    def fetch_order_by_date(date)
      order = Order
      order.created_between(date.beginning_of_day, date.end_of_day) if date.present?
    end
  end
end
