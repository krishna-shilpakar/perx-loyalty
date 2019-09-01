# frozen_string_literal: true

class QuarterlyRewardJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      Services::Bonus.execute(user)
    end
  end
end
