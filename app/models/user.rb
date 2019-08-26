# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_rewards, dependent: :destroy
  has_many :rewards, through: :user_rewards
end
