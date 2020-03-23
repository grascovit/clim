# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :client

  validates :title, presence: true
  validates :start_at, presence: true
  validate :finish_is_before_start

  scope :sorted_by_start_at, -> { order(start_at: :asc) }

  private

  def finish_is_before_start
    return unless start_at && finish_at

    errors.add(:finish_at, :finish_before_start) if finish_at < start_at
  end
end
