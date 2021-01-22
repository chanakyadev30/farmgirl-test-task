require 'rails_helper'

describe FindOrder do
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
        expect(errors).to have_key :id
        expect(errors[:id]).to include 'is required'
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
        inputs[:id] = ''
        expect(outcome).to_not be_valid
        expect(errors).to have_key :id
        expect(errors[:id]).to include "can't be blank"
      end
    end

    context 'with bang operator' do
      it 'should in validates with attribute' do
        inputs[:id] = ''
        expect { outcome! }.to raise_error ActiveInteraction::InvalidInteractionError
      end
    end
  end

  describe '#executes' do
    context 'without bang operator' do
      it 'should executes with valid attribute' do
        inputs[:id] = order.id
        expect(outcome).to be_valid
        expect(result).to eq order
      end
    end

    context 'with bang operator' do
      it 'should executes with valid attribute' do
        inputs[:id] = order.id
        expect { outcome! }.to_not raise_error
        expect(outcome!).to eq order
      end
    end
  end
end
