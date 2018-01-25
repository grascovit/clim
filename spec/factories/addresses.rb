# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    primary_address { Faker::Address.street_address }
    secondary_address { Faker::Address.secondary_address }
    number { Faker::Address.building_number }
    zip_code { Faker::Address.zip_code }
    neighborhood { Faker::Address.community }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    addressable
  end
end
