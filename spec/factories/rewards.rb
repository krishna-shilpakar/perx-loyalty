# frozen_string_literal: true

FactoryBot.define do
  factory :reward do
    name { 'Standard Transaction' }

    trait :standard do
      name { 'Standard Transaction' }
    end

    trait :coffee do
      name { 'Free Coffee' }
    end

    trait :cash_rebate do
      name { '5% Cash rebate' }
    end

    trait :ticket do
      name { 'Free Ticket' }
    end

    trait :lounge_access do
      name { '4x Airport Lounge Access' }
    end

    trait :bonus do
      name { 'Bonus Point' }
    end
  end
end
