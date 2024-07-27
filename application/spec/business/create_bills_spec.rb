require 'rails_helper'
require_relative '../../app/business/create_bills'

RSpec.describe CreateBills do
  describe '.perform' do
    let(:full_value) { 1200 }
    let(:installments) { 6 }
    let(:due_day) { 31 }
    let(:enrollment_id) { 1 }

    subject { described_class.new(full_value, installments, due_day, enrollment_id).perform }

    context 'when params are invalid' do
      context 'with invalid full_value' do
        let (:full_value) { 0 }

        it do
          expect { subject }.to raise_error(ArgumentError, 'full_value must be valid')
        end
      end

      context 'with invalid installments' do
        let (:installments) { 0 }

        it do
          expect { subject }.to raise_error(ArgumentError, 'installments must be valid')
        end
      end

      context 'with invalid due_day' do
        let (:due_day) { 0 }

        it do
          expect { subject }.to raise_error(ArgumentError, 'due_day must be valid')
        end
      end
    end
  end
end
