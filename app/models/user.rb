# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_rewards, dependent: :destroy
  has_many :rewards, through: :user_rewards
  has_many :points, dependent: :destroy
  has_many :transactions, dependent: :destroy
  belongs_to :tier

  before_save :set_tier

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

  def expire_points!
    update!(loyalty_points: 0)
  end

  private

  def set_tier
    if new_record?
      self.tier = Tier.default
    elsif loyalty_points_changed?
      self.tier = tier_based_on_points
    end
  end

  def tier_based_on_points
    if loyalty_points_was < loyalty_points
      Tier.by_points(loyalty_points)
    else
      Tier.by_points(max_points_in_two_years)
    end
  end

  def max_points_in_two_years
    [last_year_points.sum(:num), previous_year_points.sum(:num)].max
  end

  def last_year_points
    points.within(1.year.ago.beginning_of_year, 1.year.ago.end_of_year)
  end

  def previous_year_points
    points.within(2.years.ago.beginning_of_year, 2.years.ago.end_of_year)
  end
end
