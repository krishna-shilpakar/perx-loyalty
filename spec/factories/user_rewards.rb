# frozen_string_literal: true

FactoryBot.define do
  factory :user_reward do
    user
    reward
    claimed { false }

    trait :coffee do
      meta { { reward_name: 'point' } }
    end

    trait :birthday do
      meta { { reward_name: 'birthday' } }
    end

    transient do
      points { nil }
    end

    after(:create) do |user_reward, evaluator|
      return if evaluator.points.blank?

      create(:point, user_reward: user_reward, user: user_reward.user, num: evaluator.points)
    end
  end
end
