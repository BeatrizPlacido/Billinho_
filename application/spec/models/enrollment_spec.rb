require 'rails_helper'
require_relative '../../app/models/enrollment'

RSpec.describe Enrollment, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:student) }
    it { is_expected.to belong_to(:institution) }
  end
end
