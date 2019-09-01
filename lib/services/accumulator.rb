# frozen_string_literal: true

module Services
  class Accumulator
    POINTS = 100

    def initialize(user)
      @user = user
    end

    def self.execute(user)
      instance = new(user)
      return false unless instance.generatable?

      user.generate_reward!('coffee',
                            source: 'accumulator',
                            accumulation_points: POINTS,
                            period: 'monthly',
                            date: Time.zone.today)
    end

    def generatable?
      @user.points.month.sum(:num) >= POINTS
    end
  end
end
