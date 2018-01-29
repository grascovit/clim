# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :client

  validates :title, presence: true
  validates :start_at, presence: true
  validates :service_fee, presence: true
  validate :finish_is_before_start

  private

  def finish_is_before_start
    return unless start_at && finish_at

    errors.add(:finish_at, "can't be before the start") if finish_at < start_at
  end
end
