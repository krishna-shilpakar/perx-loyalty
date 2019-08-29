# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rewards::CoffeeGenerator do
  let!(:user) { create(:user) }
  let!(:reward) { create(:reward, :coffee) }

  subject { described_class.new(user, source: 'accumulator') }

  describe '#generate!(reward_type)' do
    let(:user_reward) { UserReward.last }

    it 'creates user_reward' do
      expect(subject.generate!).to be_truthy
      expect(UserReward.count).to eq(1)
      expect(user_reward.user).to eql(user)
      expect(user_reward.reward).to eql(reward)
      expect(subject.generate!).to be_falsy
    end
  end
end
