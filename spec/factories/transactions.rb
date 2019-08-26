FactoryBot.define do
  factory :transaction do
    amount { 0.01 }
    country { "US" }
  end
end
