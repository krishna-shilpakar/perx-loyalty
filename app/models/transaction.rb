# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true, numericality: { greater_than: 0.0 }
  after_create :transaction_reward

  private

  def transaction_reward
    Services::Transaction.execute(
      user: user,
      amount: amount,
      transaction_id: id,
      foreign: user.country != country
    )
  end
end
