# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    start_at { Faker::Time.between(1.day.from_now, 7.days.from_now) }
    finish_at { Faker::Time.between(2.days.from_now, 8.days.from_now) }
    service_fee { Faker::Number.decimal(2) }
    client
  end
end
