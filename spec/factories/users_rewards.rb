FactoryBot.define do
  factory :users_reward do
    user
    reward
    claimed { false }
  end
end
