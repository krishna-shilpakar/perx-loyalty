# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true, numericality: { greater_than: 0.0 }
  after_create :transaction_reward

  private

  def transaction_reward
    Rewards::Transaction.generate!(
      user: user,
      amount: amount,
      foreign: user.country != country
    )
  end
end
