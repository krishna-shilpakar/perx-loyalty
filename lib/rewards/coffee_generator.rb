# frozen_string_literal: true

module Rewards
  class CoffeeGenerator < Generator
    def generate!
      super(Reward.coffee.first)
    end
  end
end
