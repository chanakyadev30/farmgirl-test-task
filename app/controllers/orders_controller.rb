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
  def show; end

  # PUT /orders/fulfill
  def fulfill; end

  private

  def order_params
    params.require(:order).permit(order_items_attributes: %i[product_id quantity])
  end

  # parsed date params, use today if not a valid date
  def set_date
    @date = Date.current
  end
end
