class Point < ApplicationRecord
  belongs_to :users_reward

  validates :num, presence: true
end
