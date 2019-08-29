# frozen_string_literal: true

RSpec.configure do |config|
  config.before :each do |_example|
    FactoryBot.create(:tier, :standard)
    FactoryBot.create(:tier, :gold)
    FactoryBot.create(:tier, :platinum)
  end
end
