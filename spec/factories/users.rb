# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    country { nil }
    loyalty_points { 0 }
    tier { Tier.default }

    trait :gold do
      after(:create) { |user| user.update(tier: Tier.gold) }
    end
  end
end
