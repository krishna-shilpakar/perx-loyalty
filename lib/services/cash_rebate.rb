# frozen_string_literal: true

module Services
  class CashRebate
    AMOUNT = 100
    LIMIT = 10

    def initialize(user)
      @user = user
    end

    def self.store(user, amount, created_at, transaction_id); end

    def self.execute(user)
      instance = new(user)
      return false unless instance.generatable?

      user.generate_reward!('cash_rebate',
                            source: 'cash_rebate', limit: LIMIT,
                            sum_amount: AMOUNT)
    end

    def generatable?
      @user.transactions.order(created_at: :desc)
           .limit(LIMIT).sum(:amount) >= AMOUNT
    end
  end
end
