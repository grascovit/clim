# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :clients, dependent: :destroy

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }
end
