# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_rewards, dependent: :destroy
  has_many :rewards, through: :user_rewards
  has_many :points, dependent: :destroy
  has_many :transactions, dependent: :destroy
  belongs_to :tier

  before_create :default_tier

  def generate_reward!(reward_type, meta = {})
    case reward_type
    when 'standard'
      Rewards::TransactionGenerator.new(self, meta).generate!
    when 'coffee'
      Rewards::Generator.new(self, meta).generate!(Reward.coffee.first)
    when 'cash_rebate'
      Rewards::Generator.new(self, meta).generate!(Reward.cash_rebate.first)
    when 'ticket'
      Rewards::Generator.new(self, meta).generate!(Reward.ticket.first)
    when 'lounge_access'
      Rewards::Generator.new(self, meta).generate!(Reward.lounge_access.first)
    when 'bonus'
      Rewards::Generator.new(self, meta).generate!(Reward.bonus.first)
    end
  end

  private

  def default_tier
    self.tier = Tier.default
  end
end
