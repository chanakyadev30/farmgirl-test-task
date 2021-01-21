require 'rails_helper'

RSpec.describe DistributionCenterProduct, type: :model do
  subject { create(:distribution_center_product) }

  describe 'Schema' do
    it { is_expected.to have_db_column(:distribution_center_id).of_type(:integer) }
    it { is_expected.to have_db_column(:product_id).of_type(:integer) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:distribution_center) }
  end

  describe 'Validations' do
    it { is_expected.to validate_uniqueness_of(:product_id).scoped_to(:distribution_center_id) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a distribution_center_id' do
      subject.distribution_center_id = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a distribution_center_id' do
      subject.product_id = nil
      expect(subject).to_not be_valid
    end
  end
end
