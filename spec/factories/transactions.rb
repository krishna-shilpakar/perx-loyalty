# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    amount { 0.01 }
    country { 'US' }
    user
  end
end
