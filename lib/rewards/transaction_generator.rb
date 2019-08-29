# frozen_string_literal: true

module Rewards
  class TransactionGenerator < Generator
    def generate!
      reward = super(Reward.standard.first)
      return unless reward

      @user.points.create!(
        user_reward: reward, num: reward.meta['reward_points']
      )
      reward.claim!
      @user.update!(loyalty_points: points)
    end

    def points
      @user.loyalty_points + @meta.stringify_keys['reward_points']
    end
  end
end
