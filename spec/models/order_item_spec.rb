require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  subject { create(:order_item) }

  describe 'Schema' do
    it { is_expected.to have_db_column(:order_id).of_type(:uuid) }
    it { is_expected.to have_db_column(:product_id).of_type(:integer) }
    it { is_expected.to have_db_column(:quantity).of_type(:integer) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:order) }
  end

  describe 'Validations' do
    it { is_expected.to validate_uniqueness_of(:product_id).scoped_to(:order_id) }
    it do
      is_expected.to validate_numericality_of(:quantity)
        .is_less_than_or_equal_to(OrderItem::MAX_QUANTITY)
        .is_greater_than_or_equal_to(OrderItem::MIN_QUANTITY)
    end

    it 'is valid with attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid without order' do
      subject.order = nil
      expect(subject).not_to be_valid
    end

    it 'is invalid without product' do
      subject.product = nil
      expect(subject).not_to be_valid
    end
  end
end
