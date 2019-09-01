# frozen_string_literal: true

class MonthlyRewardJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      Services::Accumulator.execute(user)
      Services::Birthday.execute(user)
      Services::MovieTicket.execute(user)
    end
  end
end
