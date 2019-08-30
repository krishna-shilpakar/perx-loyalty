# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Tier do
  let!(:user) { create(:user, :gold) }
  let!(:reward) { create(:reward, :lounge_access) }
  subject { described_class }

  describe '#generatable?' do
    context 'generatable' do
      it 'is true' do
        expect(subject.new(user.reload).generatable?).to be_truthy
      end
    end

    context 'non generatable' do
      let!(:user) { create(:user) }
      it 'is false' do
        expect(subject.new(user.reload).generatable?).to be_falsey
      end
    end
  end

  describe '.execute' do
    let(:user_reward) { UserReward.last }
    let(:meta_keys) { %w[source tier_name].sort }

    it 'generate reward' do
      expect(described_class.execute(user.reload)).to be_truthy
      expect(user_reward.user).to eql(user)
      expect(user_reward.claimed).to be_falsey
      expect(user_reward.reward).to eql(reward)
      expect(user_reward.meta.keys.sort).to eql(meta_keys)
      expect(user_reward.meta['source']).to eql('tier')
      expect(user_reward.meta['tier_name']).to eql('Gold')
      expect(described_class.execute(user)).to be_falsey
    end
  end
end
