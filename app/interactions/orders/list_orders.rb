class ListOrders < ActiveInteraction::Base
  date :date
  string :page, default: nil

  def execute
    Order
      .includes(:products, :order_items)
      .preload(:fulfiller)
      .created_between(date.beginning_of_day, date.end_of_day)
      .by_recent
      .paginate(
        page: page,
        per_page: Order::PER_PAGE
      )
  end
end
