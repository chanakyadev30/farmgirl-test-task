require 'rails_helper'

RSpec.describe DistributionCenter, type: :model do
  subject { build(:distribution_center) }

  describe 'Schema' do
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:orders) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end
end
