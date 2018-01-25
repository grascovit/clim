# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:addressable) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:primary_address) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:country) }
  end
end
