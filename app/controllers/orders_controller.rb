class OrdersController < ApplicationController
  before_action :set_date, only: :index

  # GET /orders
  def index
    @orders = ListOrders.run!(date: @date, page: params[:page])
  end

  def new; end

  private

  # parsed date params, use today if not a valid date
  def set_date
    @date = Date.current
  end
end
