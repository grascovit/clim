# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:client) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:start_at) }
    it { is_expected.to validate_presence_of(:service_fee) }
  end

  describe '#finish_is_before_start' do
    context 'when finish is before start' do
      it 'adds error to task model' do
        task = build(:task, start_at: 1.day.from_now, finish_at: 1.day.ago)
        task.valid?

        expect(task.errors.full_messages).to eq(["Finish at can't be before the start"])
      end
    end

    context 'when finish is after start' do
      it 'does not add error to task model' do
        task = create(:task, start_at: 1.day.ago, finish_at: 1.day.from_now)

        expect(task.errors.full_messages).to eq([])
      end
    end
  end
end
