# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :clients, dependent: :destroy
  has_many :tasks, through: :clients

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }
  validate :financial_document_presence
  validates :cpf, uniqueness: true, if: :cpf?
  validates :cnpj, uniqueness: true, if: :cnpj?

  def financial_document_presence
    errors.add(:base, :financial_documents_missing) if cpf.blank? && cnpj.blank?
  end
end
