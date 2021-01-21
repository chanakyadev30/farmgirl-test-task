require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { build(:order) }

  describe 'Schema' do
    it { is_expected.to have_db_column(:status).of_type(:integer) }
    it { is_expected.to have_db_column(:fulfiller_id).of_type(:integer) }
    it { is_expected.to have_db_column(:fulfiller_type).of_type(:string) }
  end

  describe 'Validations' do
    it { is_expected.to define_enum_for(:status).with_values(Order.statuses.keys) }

    it 'is valid with attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid without fulfiller' do
      order = build(:order, fulfiller_id: nil, fulfiller_type: nil)
      expect(order).to_not be_valid
    end
  end
end
