# frozen_string_literal: true

module Services
  class Transaction
    STANDARD_SPENDING = 100.00
    STANDARD_REWARD_POINTS = 10
    FOREIGN_SPENDINGS_REWARD_POINTS = 2 * STANDARD_REWARD_POINTS

    def initialize(user, amount, foreign)
      @user = user
      @amount = amount
      @foreign = foreign
    end

    def self.execute(user:, amount:, transaction_id:, foreign: false)
      instance = new(user, amount, foreign)
      return false unless instance.generatable?

      user.generate_reward!('standard',
                            source: 'transaction',
                            transaction_id: transaction_id,
                            reward_points: instance.reward_points)
    end

    def generatable?
      @foreign || @amount >= STANDARD_SPENDING
    end

    def reward_points
      @reward_points ||= transaction_reward_points
    end

    private

    def transaction_reward_points
      return FOREIGN_SPENDINGS_REWARD_POINTS if @foreign

      STANDARD_REWARD_POINTS if @amount >= STANDARD_SPENDING
    end
  end
end
