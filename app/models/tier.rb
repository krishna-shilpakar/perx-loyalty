# frozen_string_literal: true

class Tier < ApplicationRecord
  NAMES = [
    { name: 'Standard', points: (0..999) },
    { name: 'Gold', points: (1000..4999) },
    { name: 'Platinum', points: (5000..Float::INFINITY) }
  ].freeze
  validates :name, presence: true, inclusion: { in: NAMES.map { |t| t[:name] } }

  scope :standard, -> { find_by(name: 'Standard') }
  scope :gold, -> { find_by(name: 'Gold') }
  scope :platinum, -> { find_by(name: 'Platinum') }
  scope :default, -> { standard }

  def default?
    name == 'Standard'
  end

  def gold?
    name == 'Gold'
  end

  def platinum?
    name == 'Platinum'
  end

  def self.by_points(point)
    send(Tier::NAMES.find { |t| t[:points].include?(point) }[:name].downcase)
  end
end
