class UsersReward < ApplicationRecord
  belongs_to :user
  belongs_to :reward
  has_many :points
end
