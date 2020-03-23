# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:client) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:start_at) }
  end

  describe 'scopes' do
    describe '.sorted_by_start_at' do
      it 'returns the tasks sorted by ascending start at' do
        task_a = create(:task, start_at: 1.day.from_now, finish_at: 2.days.from_now)
        task_b = create(:task, start_at: 3.days.from_now, finish_at: 4.days.from_now)
        task_c = create(:task, start_at: 7.days.from_now, finish_at: 8.days.from_now)

        expect(described_class.sorted_by_start_at).to eq([task_a, task_b, task_c])
      end
    end
  end

  describe '#finish_is_before_start' do
    context 'when finish is before start' do
      it 'adds error to task model' do
        task = build(:task, start_at: 1.day.from_now, finish_at: 1.day.ago)
        task.valid?

        expect(task.errors.full_messages).to eq(
          [
            'Horário de término não pode ser anterior ao horário de início'
          ]
        )
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
