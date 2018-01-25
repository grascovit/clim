# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :primary_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
end
