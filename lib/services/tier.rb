# frozen_string_literal: true

module Services
  class Tier
    def initialize(user)
      @user = user
    end

    def self.store(user, tier_name, tier_id); end

    def self.execute(user)
      instance = new(user)
      return false unless instance.generatable?

      user.generate_reward!('lounge_access', source: 'tier', tier_name: 'Gold')
    end

    def generatable?
      @user.tier.gold?
    end
  end
end
