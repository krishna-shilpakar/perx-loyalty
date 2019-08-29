# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rewards::TransactionGenerator do
  let!(:user) { create(:user) }
  let!(:reward) { create(:reward, :standard) }

  subject { described_class.new(user, source: 'transaction', reward_points: 10.0) }

  describe '#generate!' do
    let(:user_reward) { UserReward.last }

    it 'creates user_reward' do
      expect(subject.generate!).to be_truthy
      expect(UserReward.count).to eq(1)
      expect(user_reward.user).to eql(user)
      expect(user_reward.reward).to eql(reward)
      expect(user_reward.claimed).to be_truthy
      expect(user.reload.loyalty_points).to eql(10)
      expect(subject.generate!).to be_falsy
    end
  end
end
