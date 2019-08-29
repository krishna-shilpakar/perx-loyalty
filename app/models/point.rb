# frozen_string_literal: true

class Point < ApplicationRecord
  include RangeScopes

  belongs_to :user
  belongs_to :user_reward, optional: true

  validates :num, presence: true
end
