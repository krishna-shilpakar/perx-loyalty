# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    amount { 0.01 }
    country { 'US' }
    user

    trait :without_callbacks do
      after(:build) do |trans|
        trans.class.skip_callback :create, :after, :transaction_reward
      end

      after(:create) do |trans|
        trans.class.set_callback :create, :after, :transaction_reward
      end
    end
  end
end
