# frozen_string_literal: true

module Api
  module V1
    class AddressSerializer < ActiveModel::Serializer
      attributes :id, :primary_address, :secondary_address, :number,
                 :zip_code, :neighborhood, :city, :state, :country,
                 :latitude, :longitude
    end
  end
end
