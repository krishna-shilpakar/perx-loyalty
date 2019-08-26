# frozen_string_literal: true

class Reward < ApplicationRecord

  validates :name, presence: true
  has_many :user_rewards, dependent: :destroy
  has_many :users, through: :user_rewards
end
