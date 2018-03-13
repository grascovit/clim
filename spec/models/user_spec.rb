# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:clients).dependent(:destroy) }
    it { is_expected.to have_many(:tasks).through(:clients) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to validate_uniqueness_of(:cpf) }
    it { is_expected.to validate_uniqueness_of(:cnpj) }
  end

  describe '#financial_document_presence' do
    context 'when there is no financial document present' do
      it 'adds error to user model' do
        user = build(:user, cpf: nil, cnpj: nil)
        user.valid?

        expect(user.errors.full_messages).to eq(
          [
            'Você precisa informar CPF ou CNPJ'
          ]
        )
      end
    end

    context 'when there is at least one financial document present' do
      it 'does not add error to the user model' do
        user = build(:user)
        user.valid?

        expect(user.errors.full_messages).to eq([])
      end
    end
  end
end
