require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { build(:product) }

  describe 'Schema' do
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:price).of_type(:decimal).with_options(precision: 5, scale: 2) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
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
