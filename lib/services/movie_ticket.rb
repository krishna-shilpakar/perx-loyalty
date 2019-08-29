# frozen_string_literal: true

module Services
  class MovieTicket
    AMOUNT = 1000
    DAYS = 60

    def initialize(user)
      @user = user
    end

    def self.store(user, amount, created_at, transaction_id); end

    def self.execute(user)
      instance = new(user)
      return false unless instance.generatable?

      user.generate_reward!('ticket',
                            source: 'movie_ticket',
                            days: DAYS,
                            sum_amount: AMOUNT)
    end

    def generatable?
      date_range = 60.days.ago..DateTime.current.end_of_day
      @user.transactions.order(created_at: :desc)
           .where(created_at: date_range).sum(:amount) >= AMOUNT
    end
  end
end
