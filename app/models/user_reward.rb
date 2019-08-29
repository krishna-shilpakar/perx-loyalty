# frozen_string_literal: true

class UserReward < ApplicationRecord
  include RangeScopes

  belongs_to :user
  belongs_to :reward

  validates :meta, uniqueness: { scope: %i[user reward], allow_blank: true }

  def claim!
    update!(claimed: true)
  end
end
