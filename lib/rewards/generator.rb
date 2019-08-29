# frozen_string_literal: true

module Rewards
  class Generator
    def initialize(user, meta = {})
      @user = user
      @meta = meta
    end

    def generate!(reward_type)
      user_reward = @user.user_rewards.new(reward: reward_type, meta: @meta)
      user_reward.save ? user_reward : false
    end
  end
end
