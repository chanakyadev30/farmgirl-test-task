require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:fulfillment_center) { create(:fulfillment_center) }
  let(:order) { create(:order, fulfiller: fulfillment_center) }
  let(:order_item) { create(:order_item, order: order) }
  let(:product) { create(:product) }
  let(:valid_attributes) do
    {
      order: {
        order_items_attributes: [
          product_id: product.id,
          quantity: 3
        ]
      }
    }
  end

  let(:invalid_attributes) do
    {
      order: {
        order_items_attributes: [
          quantity: 3
        ]
      }
    }
  end

  describe 'GET #index' do
    it 'should take user to index page' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'should render orders as per date' do
      get :index, params: { date: '2021-01-18' }
      expect(response).to have_http_status(:success)
    end

    it 'should display error for invalid date' do
      get :index, params: { date: 'yyyy-mm-dd' }
      expect(response).to have_http_status(:redirect)
      expect(flash[:alert]).to eq(I18n.t('errors.invalid_date'))
    end
  end

  describe 'GET #new' do
    it 'should take user to new order page' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'should take user to show order page' do
      get :show, params: { id: order }
      expect(response).to have_http_status(:success)
    end

    it 'should raises error if order not found' do
      get :show, params: { id: 'Order ID' }
      expect(response).to have_http_status(:redirect)
      expect(flash[:alert]).to eq(I18n.t('errors.not_found'))
    end
  end

  describe 'POST #create' do
    it 'should create order with order items for valid params' do
      create(:fulfillment_center)
      expect { post :create, params: valid_attributes }.to change { Order.count }.by(1)
      order = Order.last
      expect(order.product_names).to eq(product.name)
      expect(flash[:notice]).to eq(I18n.t('orders.create.success'))
      expect(response).to have_http_status(:redirect)
    end

    it 'should not create order and order items for invalid params' do
      expect { post :create, params: invalid_attributes }.to change { Order.count }.by(0)
      expect(flash[:error]).to eq(I18n.t('orders.create.error'))
    end
  end

  describe 'POST #fulfill' do
    it 'should change order status to fulfilled ' do
      order.not_fulfilled!
      post :fulfill, params: { id: order }
      order.reload
      expect(order.status).to eq I18n.t('test.orders.fulfilled_status')
      expect(flash[:notice]).to eq(I18n.t('orders.fulfill.success'))
    end

    it 'should redirect if already fulfilled' do
      order.fulfilled!
      post :fulfill, params: { id: order }
      expect(response).to redirect_to orders_path
      expect(flash[:alert]).to eq(I18n.t('orders.fulfill.already_fulfilled'))
    end

    it 'should raises error if order not found' do
      post :fulfill, params: { id: 'Order ID' }
      expect(flash[:alert]).to eq(I18n.t('errors.not_found'))
    end
  end
end
