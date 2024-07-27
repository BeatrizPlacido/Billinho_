require 'rails_helper'
require_relative '../../app/models/bill'

RSpec.describe Bill, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:enrollment) }
  end
end
