# frozen_string_literal: true

class UserReward < ApplicationRecord
  belongs_to :user
  belongs_to :reward

  def claim!
    update!(claimed: true)
  end
end
