class FulfillerService < ApplicationService
  def initialize(order)
    @order = order
  end

  def call
    fulfill(@order)
  end

  private

  # first alot distribution center for an order
  # alot fulfillment center if no distribution center fulfill order
  def fulfill(order)
    product_ids = order.order_items.map(&:product_id).uniq
    filler_id = get_distributer_fulfiller_id(product_ids)
    return DistributionCenter.find_by_id(filler_id) if filler_id

    FulfillmentCenter.first
  end

  # first distribution center having all given products with product_ids
  def get_distributer_fulfiller_id(product_ids)
    return if product_ids.empty?

    DistributionCenterProduct
      .with_products(product_ids)
      .group(:distribution_center_id)
      .count
      .select { |_distribution_center_id, products_count| products_count == product_ids.length }
      .keys
      .first
  end
end
