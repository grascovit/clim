# frozen_string_literal: true

module Api
  module V1
    class ClientSerializer < ActiveModel::Serializer
      attributes :id, :name, :phone

      has_one :address, serializer: AddressSerializer
    end
  end
end
