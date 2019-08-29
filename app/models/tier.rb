# frozen_string_literal: true

class Tier < ApplicationRecord
  NAMES = %w[Standard Gold Platinum].freeze

  validates :name, presence: true, inclusion: { in: NAMES }

  scope :default, -> { find_by(name: 'Standard') }
  scope :gold, -> { find_by(name: 'Gold') }
  scope :Platinum, -> { find_by(name: 'Platinum') }

  def default?
    name == 'Standard'
  end

  def gold?
    name == 'Gold'
  end

  def platinum?
    name == 'Platinum'
  end
end
