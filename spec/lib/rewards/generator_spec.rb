# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rewards::Generator do
  let!(:user) { create(:user) }
  let!(:reward_type) { create(:reward) }

  subject { described_class.new(user) }

  describe '#award_reward!(reward_type)' do
    let(:user_reward) { UserReward.last }

    it 'creates user_reward' do
      expect(subject.award_reward!(reward_type)).to be_truthy
      expect(UserReward.count).to eq(1)
      expect(user_reward.user).to eql(user)
      expect(user_reward.reward).to eql(reward_type)
      expect(user_reward.claimed).to be_falsy
    end
  end
end
