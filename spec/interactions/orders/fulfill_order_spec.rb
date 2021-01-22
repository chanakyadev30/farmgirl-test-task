require 'rails_helper'

describe FulfillOrder do
  let(:inputs) { {} }
  let(:outcome) { described_class.run(inputs) }
  let(:outcome!) { described_class.run!(inputs) }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:order) { create(:order) }

  describe '#checks' do
    context 'without bang operator' do
      it 'should invalid with invalid type' do
        expect(outcome).to_not be_valid
        expect(errors).to have_key :order
        expect(errors[:order]).to include 'is required'
      end
    end

    context 'with bang operator' do
      it 'should raise error with invalid type' do
        expect { outcome! }.to raise_error ActiveInteraction::InvalidInteractionError
      end
    end
  end

  describe '#validates' do
    context 'without bang operator' do
      it 'should in validates with attribute' do
        inputs[:order] = ''
        expect(outcome).to_not be_valid
        expect(errors).to have_key :order
        expect(errors[:order]).to include 'is not a valid object'
      end
    end

    context 'with bang operator' do
      it 'should in validates with attribute' do
        inputs[:order] = ''
        expect { outcome! }.to raise_error ActiveInteraction::InvalidInteractionError
      end
    end
  end

  describe '#executes' do
    context 'without bang operator' do
      it 'should executes with valid attribute' do
        inputs[:order] = order
        expect(outcome).to be_valid
        expect(order.fulfilled?).to be_truthy
      end
    end

    context 'with bang operator' do
      it 'should executes with valid attribute' do
        inputs[:order] = order
        expect { outcome! }.to_not raise_error
        expect(order.fulfilled?).to be_truthy
      end
    end
  end
end
