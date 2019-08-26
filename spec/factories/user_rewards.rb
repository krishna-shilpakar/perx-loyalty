# frozen_string_literal: true

FactoryBot.define do
  factory :user_reward do
    user
    reward
    claimed { false }
  end
end
