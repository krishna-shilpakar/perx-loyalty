# frozen_string_literal: true

module Rewards
  class Generator
    def initialize(user)
      @user = user
    end

    def award_reward!(reward_type)
      UserReward.create!(user: @user, reward: reward_type)
    end
  end
end
