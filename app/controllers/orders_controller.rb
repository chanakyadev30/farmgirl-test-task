class OrdersController < ApplicationController
  before_action :set_date, only: :index

  # GET /orders
  def index
    @orders = ListOrders.run!(date: @date, page: params[:page])
  end

  # GET /orders/new
  def new
    @order = CreateOrder.new
  end

  # POST /orders
  def create
    order = Order.new(order_params)
    # passing order object due to nested params
    outcome = CreateOrder.run(order: order)

    if outcome.valid?
      redirect_to orders_path, notice: t('orders.create.success')
    else
      @order = outcome.result
      flash.now[:error] = t('orders.create.error')
      render :new
    end
  end

  # GET /orders/1
  def show
    @order = find_order
  end

  # PUT /orders/fulfill
  def fulfill
    outcome = FulfillOrder.run(order: find_order)

    if outcome.valid?
      redirect_to orders_path, notice: t('orders.fulfill.success')
    else
      redirect_to orders_path, alert: outcome.errors.full_messages.to_sentence
    end
  end

  private

  def find_order
    outcome = FindOrder.run(params)

    raise ActiveRecord::RecordNotFound unless outcome.valid?

    outcome.result
  end

  def order_params
    params.require(:order).permit(order_items_attributes: %i[product_id quantity])
  end

  # parsed date params, use today if not a valid date
  def set_date
    @date = DateParserService.call(params[:date]) || Date.current
  end
end
