# frozen_string_literal: true

FactoryBot.define do
  factory :reward do
    name { 'Standard Transaction' }

    trait :standard do
      name { 'Standard Transaction' }
    end
  end
end
