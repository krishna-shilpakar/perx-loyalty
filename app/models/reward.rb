class Reward < ApplicationRecord
  has_many :users_rewards
  has_many :users, through: :users_rewards
  has_many :points

  validates :name, presence: true
end
