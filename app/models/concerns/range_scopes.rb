# frozen_string_literal: true

module RangeScopes
  extend ActiveSupport::Concern

  included do
    scope :month, -> { where(created_at: DateTime.current.beginning_of_month..DateTime.current.end_of_month) } # rubocop:disable Metrics/LineLength
    scope :within, ->(start_at, end_at) { where(created_at: start_at..end_at) }
  end
end
