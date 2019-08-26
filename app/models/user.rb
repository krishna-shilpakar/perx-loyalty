class User < ApplicationRecord
  has_many :users_rewards
  has_many :rewards, through: :users_rewards
end
