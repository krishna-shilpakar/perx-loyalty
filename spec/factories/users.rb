FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    loyalty_points { 0 }
  end
end
