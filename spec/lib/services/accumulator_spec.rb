# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Accumulator do
  let!(:user) { create(:user) }
  let!(:reward) { create(:reward, :coffee) }
  let!(:point1) { create(:point, user: user, num: 90) }
  before do
    Timecop.freeze(DateTime.current.last_month)
    create(:point, user: user, num: 100)
    Timecop.return
  end

  subject { described_class }

  describe '#generatable?' do
    context 'generatable' do
      let!(:point2) { create(:point, user: user, num: 11) }
      it 'is true' do
        expect(subject.new(user).generatable?).to be_truthy
      end
    end

    context 'non generatable' do
      it 'is false' do
        expect(subject.new(user).generatable?).to be_falsey
      end
    end
  end

  describe '.execute' do
    let!(:point2) { create(:point, user: user, num: 11) }
    let(:user_reward) { UserReward.last }
    let(:meta_keys) { %w[source accumulation_points period month year].sort }

    it 'generate reward' do
      expect(described_class.execute(user)).to be_truthy
      expect(user_reward.user).to eql(user)
      expect(user_reward.claimed).to be_falsey
      expect(user_reward.reward).to eql(reward)
      expect(user_reward.meta.keys.sort).to eql(meta_keys)
      expect(user_reward.meta['source']).to eql('accumulator')
      expect(described_class.execute(user)).to be_falsey
    end
  end
end
