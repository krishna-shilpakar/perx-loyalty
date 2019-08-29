# frozen_string_literal: true

FactoryBot.define do
  factory :tier do
    name { 'Standard' }
    trait :standard do
      name { 'Standard' }
    end

    trait :gold do
      name { 'Gold' }
    end

    trait :platinum do
      name { 'Platinum' }
    end
  end
end
