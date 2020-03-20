# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
    it { is_expected.to have_one(:address).dependent(:destroy) }
    it { is_expected.to accept_nested_attributes_for(:address) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:phone) }
  end

  describe 'scopes' do
    describe '.sorted_by_name' do
      it 'returns the clients sorted by alphabetical order' do
        client_a = create(:client, name: 'A')
        client_b = create(:client, name: 'B')
        client_c = create(:client, name: 'C')

        expect(described_class.sorted_by_name).to eq([client_a, client_b, client_c])
      end
    end
  end
end
