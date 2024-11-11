require 'rails_helper'
require_relative '../../app/models/institution'

RSpec.describe Institution, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:enrollments) }
  end
end
