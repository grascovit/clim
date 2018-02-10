# frozen_string_literal: true

class Client < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_one :address, as: :addressable, inverse_of: :addressable, dependent: :destroy

  validates :name, presence: true
  validates :phone, presence: true

  accepts_nested_attributes_for :address

  scope :sorted_by_name, -> { order(name: :asc) }
end
