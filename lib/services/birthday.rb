# frozen_string_literal: true

module Services
  class Birthday
    def initialize(user)
      @user = user
    end

    def self.store(user, dob)
      # saves user_id and point_id, created_at point_num
    end

    def self.execute(user)
      instance = new(user)
      return false unless instance.generatable?

      user.generate_reward!('coffee',
                            source: 'birthday',
                            year: Time.zone.today.year)
    end

    def generatable?
      @user.date_of_birth.month == Time.zone.today.month
    end
  end
end
