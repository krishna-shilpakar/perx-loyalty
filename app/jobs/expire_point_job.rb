# frozen_string_literal: true

class ExpirePointJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each(&:expire_points!)
  end
end
