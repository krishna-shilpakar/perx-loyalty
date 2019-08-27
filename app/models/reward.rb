# frozen_string_literal: true

class Reward < ApplicationRecord
  enum name: {
    standard: 'Standard Transaction',
    coffee: 'Free Coffee',
    cash_rebate: '5% Cash rebate',
    ticket: 'Free Ticket',
    lounge_access: '4x Airport Lounge Access',
    bonus: 'Bonus Point'
  }

  has_many :user_rewards, dependent: :destroy
  has_many :users, through: :user_rewards

  validates :name, presence: true, uniqueness: true
end
