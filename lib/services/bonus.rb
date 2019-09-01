# frozen_string_literal: true

module Services
  class Bonus
    AMOUNT = 2000

    def initialize(user)
      @user = user
    end

    def self.store(user, amount, created_at, transaction_id); end

    def self.execute(user)
      instance = new(user)
      return false unless instance.generatable?

      user.generate_reward!('bonus',
                            source: 'bonus',
                            period: 'quarterly',
                            date: Time.zone.today.beginning_of_quarter,
                            sum_amount: AMOUNT)
    end

    def generatable?
      quar = DateTime.current.beginning_of_quarter..DateTime.current.end_of_day
      @user.transactions.order(created_at: :desc)
           .where(created_at: quar).sum(:amount) >= AMOUNT
    end
  end
end
