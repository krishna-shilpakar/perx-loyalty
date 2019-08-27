# frozen_string_literal: true

module Rewards
  class Transaction < Generator
    STANDARD_SPENDING = 100.00
    STANDARD_REWARD_POINTS = 10
    FOREIGN_SPENDINGS_REWARD_POINTS = 2 * STANDARD_REWARD_POINTS

    def initialize(user, amount, foreign)
      super(user)
      @amount = amount
      @foreign = foreign
    end

    def self.generate!(user:, amount:, foreign: false)
      instance = new(user, amount, foreign)
      return false unless instance.generatable?

      instance.award_reward!
    end

    def generatable?
      @foreign || @amount >= STANDARD_SPENDING
    end

    def award_reward!
      reward = super(Reward.standard.first)
      Point.create!(num: reward_points, user_reward: reward)
      reward.claim!
      @user.update!(loyalty_points: @user.loyalty_points + reward_points)
    end

    private

    def reward_points
      @reward_points ||= transaction_reward_points
    end

    def transaction_reward_points
      return FOREIGN_SPENDINGS_REWARD_POINTS if @foreign

      STANDARD_REWARD_POINTS if @amount >= STANDARD_SPENDING
    end
  end
end
