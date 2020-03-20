# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    start_at { Faker::Time.between(from: 1.day.ago, to: Time.current) }
    finish_at { Faker::Time.between(from: 1.day.from_now, to: 2.days.from_now) }
    service_fee { Faker::Number.decimal(l_digits: 2) }
    client
  end
end
