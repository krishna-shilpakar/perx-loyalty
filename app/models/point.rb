# frozen_string_literal: true

class Point < ApplicationRecord
  belongs_to :user_reward

  validates :num, presence: true
end
